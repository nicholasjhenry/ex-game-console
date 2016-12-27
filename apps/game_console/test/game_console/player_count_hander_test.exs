defmodule GameConsole.PlayerCountHandlerTest do
  use GameConsole.Case

  alias GameConsole.{PlayerCountHandler, PlayerCreated}

  setup do
    PlayerCountHandler.reset

    :ok
  end

  test "player created adds 1 to the count" do
    PlayerCountHandler.handle(%PlayerCreated{}, %{})
    PlayerCountHandler.handle(%PlayerCreated{}, %{})
    assert PlayerCountHandler.count == 2
  end
end
