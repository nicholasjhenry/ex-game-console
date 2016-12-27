defmodule GameConsole.CreatePlayerHandler do
  @behaviour Commanded.Commands.Handler

  alias GameConsole.{Player, CreatePlayer}

  def handle(%Player{} = aggregate, %CreatePlayer{name: name}) do
    Player.create(aggregate, name)
  end
end
