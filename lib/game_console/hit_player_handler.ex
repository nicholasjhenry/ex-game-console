defmodule GameConsole.HitPlayerHandler do
  @behaviour Commanded.Commands.Handler

  alias GameConsole.{Player, HitPlayer}

  def handle(%Player{} = aggregate, %HitPlayer{damage: damage}) do
    Player.hit(aggregate, damage)
  end
end
