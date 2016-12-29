defmodule GameConsole.PlayerCountHandlerTest do
  use GameConsole.Case

  alias GameConsole.{PlayerCountHandler, PlayerRegistered}

  setup do
    PlayerCountHandler.reset

    :ok
  end

  test "player created adds 1 to the count" do
    PlayerCountHandler.handle(%PlayerRegistered{}, %{})
    PlayerCountHandler.handle(%PlayerRegistered{}, %{})
    assert PlayerCountHandler.count == 2
  end
end
