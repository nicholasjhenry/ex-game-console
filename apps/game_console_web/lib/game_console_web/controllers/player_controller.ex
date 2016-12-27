defmodule GameConsoleWeb.PlayerController do
  use GameConsoleWeb.Web, :controller

  def new(conn, _params) do
    render conn, "new.html", player_count: GameConsole.PlayerCountHandler.count
  end

  def create(conn, %{"player" => params}) do
    :ok = GameConsole.Router.dispatch(struct(GameConsole.CreatePlayer, name: params["name"]))
    redirect conn, to: player_path(conn, :new)
  end
end
