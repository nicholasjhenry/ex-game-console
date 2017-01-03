defmodule GameConsolePresentation.ActivePlayer do
  use Projections.Projection

  schema "active_player" do
    field :name, :string
    field :health, :integer
    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :health])
  end

  defmodule Projector do
    @behaviour Commanded.Event.Handler
    @projection_name "active_player"

    alias GameConsolePresentation.{ActivePlayer, PlayerHit}

    def handle(%GameConsole.PlayerRegistered{name: name, health: health}, %{event_id: event_id}) do
      ActivePlayer.update_projection(@projection_name, event_id, fn multi ->
        Ecto.Multi.insert(multi, :example, %ActivePlayer{
          name: name,
          health: health
        })
      end)
    end

    def handle(%GameConsole.PlayerHit{name: player_name, remaining_health: remaining_health}, %{event_id: event_id} = event) do
      active_player = Repo.get_by(ActivePlayer, name: player_name)
      changeset = ActivePlayer.changeset(active_player, %{health: remaining_health})
      ActivePlayer.update_projection(@projection_name, event_id, fn multi ->
        Ecto.Multi.update(multi, :example, changeset)
      end)

      :ok
    end

    def handle(_event, _metadata), do: :ok
  end
end
