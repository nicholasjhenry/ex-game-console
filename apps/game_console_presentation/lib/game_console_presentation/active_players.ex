defmodule GameConsolePresentation.ActivePlayers do
  use Projections.Projection

  schema "active_players" do
    field :name, :string
    field :health, :integer
    timestamps
  end

  defmodule Projector do
    @behaviour Commanded.Event.Handler

    @projection_name "active_players"

    alias GameConsolePresentation.ActivePlayers

    def handle(%GameConsole.PlayerCreated{name: name, health: health}, %{event_id: event_id}) do
      ActivePlayers.update_projection(@projection_name, event_id, fn multi ->
        Ecto.Multi.insert(multi, :example, %ActivePlayers{
          name: name,
          health: health
        })
      end)
    end

    # ignore all other events
    def handle(_event, _metadata), do: :ok
  end
end
