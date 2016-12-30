defmodule GameConsolePresentation.PlayerCounterTest do
  use GameConsolePresentation.Case

  alias GameConsole.PlayerRegistered
  alias GameConsolePresentation.PlayerCounter

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
