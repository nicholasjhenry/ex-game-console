defmodule GameConsoleWeb.HitController do
  use GameConsoleWeb.Web, :controller

  def create(conn, %{"player_id" => name, "hit" => %{"damage" => damage}}) do
    :ok = GameConsole.Router.dispatch(
      struct(GameConsole.HitPlayer, name: name, damage: String.to_integer(damage))
    )
    redirect conn, to: player_path(conn, :show, name)
  end
end
