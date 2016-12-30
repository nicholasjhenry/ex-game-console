defmodule GameConsole.Router do
  use Commanded.Commands.Router
  middleware Commanded.Middleware.Logger

  alias GameConsole.{
    Player,
    RegisterPlayer,
    HitPlayer,
    PlayerApplicationService
  }

  dispatch [RegisterPlayer, HitPlayer], to: PlayerApplicationService, aggregate: Player, identity: :name
end
