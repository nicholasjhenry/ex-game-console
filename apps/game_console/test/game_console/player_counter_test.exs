defmodule GameConsole.PlayerCounterTest do
  use GameConsole.Case

  alias GameConsole.{PlayerCounter, PlayerRegistered}

  setup do
    PlayerCounter.reset

    :ok
  end

  test "player created adds 1 to the count" do
    PlayerCounter.handle(%PlayerRegistered{}, %{})
    PlayerCounter.handle(%PlayerRegistered{}, %{})
    assert PlayerCounter.count == 2
  end
end
