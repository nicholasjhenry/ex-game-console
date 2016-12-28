defmodule GameConsolePresentation.PlayerStatus do
  use Projections.Projection

  schema "player_statuses" do
    field :name, :string
    field :status, :string
    timestamps
  end

  defmodule Projector do
    @behaviour Commanded.Event.Handler

    @projection_name "player_status"

    alias GameConsolePresentation.PlayerStatus

    def handle(%GameConsole.PlayerCreated{name: name}, %{event_id: event_id}) do
      PlayerStatus.update_projection(@projection_name, event_id, fn multi ->
        Ecto.Multi.insert(multi, :example, %PlayerStatus{
          name: name
        })
      end)
    end

    # ignore all other events
    def handle(_event, _metadata), do: :ok
  end
end
