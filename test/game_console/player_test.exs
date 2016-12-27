defmodule GameConsole.PlayerTest do
  use GameConsole.Case

  alias GameConsole.{Router, CreatePlayer, HitPlayer}

  test "creating a player returns a new player" do
    result = Router.dispatch(%CreatePlayer{name: "sarah"})
    assert :ok == result
  end

  test "creating a player twice with the same name returns an error" do
    Router.dispatch(%CreatePlayer{name: "jane"})
    result = Router.dispatch(%CreatePlayer{name: "jane"})
    assert {:error, :player_exists_with_name} == result
  end

  # Assume we cannot create a player with the same identity as it is being
  # tracked by the "commanded" process
  #
  test "hitting a player reduces health" do
    :ok = Router.dispatch(%CreatePlayer{name: "bob"})

    result = Router.dispatch(%HitPlayer{name: "bob", damage: 20})
    assert :ok == result

    {:ok, events} = EventStore.read_stream_forward("bob")
    assert length(events) == 2
  end
end
