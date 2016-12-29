defmodule GameConsole.Router do
  use Commanded.Commands.Router
  middleware Commanded.Middleware.Logger

  alias GameConsole.{
    Player,
    RegisterPlayer,
    RegisterPlayerHandler,
    HitPlayer,
    HitPlayerHandler
  }

  dispatch RegisterPlayer, to: RegisterPlayerHandler, aggregate: Player, identity: :name
  dispatch HitPlayer, to: HitPlayerHandler, aggregate: Player, identity: :name
end
