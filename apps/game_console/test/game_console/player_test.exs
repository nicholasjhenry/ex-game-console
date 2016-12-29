defmodule GameConsole.PlayerTest do
  use GameConsole.Case

  alias GameConsole.{Router, RegisterPlayer, HitPlayer}

  test "registering a player returns a new player" do
    result = Router.dispatch(%RegisterPlayer{name: "sarah"})
    assert :ok == result
  end

  test "registering a player twice with the same name returns an error" do
    Router.dispatch(%RegisterPlayer{name: "jane"})
    result = Router.dispatch(%RegisterPlayer{name: "jane"})
    assert {:error, :player_previously_registered_with_name} == result
  end

  # Assume we cannot create a player with the same identity as it is being
  # tracked by the "commanded" process
  #
  test "hitting a player reduces health" do
    :ok = Router.dispatch(%RegisterPlayer{name: "bob"})

    result = Router.dispatch(%HitPlayer{name: "bob", damage: 20})
    assert :ok == result

    {:ok, events} = EventStore.read_stream_forward("bob")
    assert length(events) == 2
  end
end
