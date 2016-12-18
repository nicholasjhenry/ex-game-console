defmodule GameConsole.Player do
  use GenServer

  alias GameConsole.{HitPlayer, PlayerHit}

  def create(name) do
    GenServer.start_link(__MODULE__, name, [name: String.to_atom("player-#{name}")])
  end

  def init(name) do
    DisplayHelper.write_line("#{name} created")
    {:ok, %{id: UUID.uuid4, version: 0, name: name, health: 100}}
  end

  def health(player) do
    GenServer.call(player, :health)
  end

  def id(player) do
    GenServer.call(player, :id)
  end

  def handle(player, %HitPlayer{damage: damage}) do
    GenServer.cast(player, {:hit, damage})
  end

  # Server Callbacks

  def handle_cast({:hit, damage}, state) do
    DisplayHelper.write_line("#{state.name} received HitPlayer command")

    %PlayerHit{damage_taken: damage}

    events = [
      %EventStore.EventData{
        event_type: "GameConsole.PlayerHit",
        data: %{damage_taken: damage},
        metadata: %{name: state.name},
      }
    ]

    :ok = EventStore.append_to_stream(state.id, state.version, events)

    new_state = %{state | health: state.health - damage, version: state.version + 1}

    {:noreply, new_state}
  end

  def handle_call(:health, _from, state) do
    {:reply, state.health, state}
  end


  def handle_call(:id, _from, state) do
    {:reply, state.id, state}
  end
end
