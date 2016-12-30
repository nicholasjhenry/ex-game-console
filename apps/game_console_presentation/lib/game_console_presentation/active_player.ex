defmodule GameConsolePresentation.ActivePlayer do
  use Projections.Projection

  schema "active_player" do
    field :name, :string
    field :health, :integer
    timestamps
  end

  defmodule Projector do
    @behaviour Commanded.Event.Handler
    @projection_name "active_player"

    alias GameConsolePresentation.ActivePlayer

    def handle(%GameConsole.PlayerRegistered{name: name, health: health}, %{event_id: event_id}) do
      ActivePlayer.update_projection(@projection_name, event_id, fn multi ->
        Ecto.Multi.insert(multi, :example, %ActivePlayer{
          name: name,
          health: health
        })
      end)
    end
    def handle(_event, _metadata), do: :ok
  end
end
