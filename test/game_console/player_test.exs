defmodule GameConsole.PlayerTest do
  use ExUnit.Case

  alias GameConsole.{Player, HitPlayer}

  test "creating a player returns a new player" do
    response = Player.create("Sarah")
    assert {:ok, _} = response
  end

  test "hitting a player reduces health" do
    {:ok, sarah} = Player.create("Sarah")
    Player.handle(sarah, %HitPlayer{damage: 20})

    assert Player.health(sarah) == 80

    {:ok, events} = EventStore.read_stream_forward(Player.id(sarah))
    assert length(events) == 1
  end
end
