defmodule GameConsole.RegisterPlayerHandler do
  @behaviour Commanded.Commands.Handler

  alias GameConsole.{Player, RegisterPlayer}

  def handle(%Player{} = aggregate, %RegisterPlayer{name: name}) do
    Player.register(aggregate, name)
  end
end
