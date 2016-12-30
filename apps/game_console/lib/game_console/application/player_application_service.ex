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

  def handle(%Player{} = aggregate, %HitPlayer{damage: damage}) do
    Player.hit(aggregate, damage)
  end
end
