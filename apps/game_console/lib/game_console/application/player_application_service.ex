defmodule GameConsole.PlayerApplicationService do
  @behaviour Commanded.Commands.Handler

  alias GameConsole.{
    Player,
    HitPlayer,
    RegisterPlayer
  }

  def handle(%Player{} = aggregate, %RegisterPlayer{name: name}) do
    Player.register(aggregate, name)
  end

  def handle(%Player{} = aggregate, %HitPlayer{damage: damage, hitter: hitter}) do
    Player.hit(aggregate, damage, hitter)
  end
end
