defmodule GameConsole.PlayerCountHandlerTest do
  use GameConsole.Case

  alias GameConsole.{PlayerCountHandler, PlayerCreated}

  test "player created adds 1 to the count" do
    {:ok, _handler} = PlayerCountHandler.start_link
    PlayerCountHandler.handle(%PlayerCreated{}, %{})
    PlayerCountHandler.handle(%PlayerCreated{}, %{})
    assert PlayerCountHandler.count == 2
  end
end
