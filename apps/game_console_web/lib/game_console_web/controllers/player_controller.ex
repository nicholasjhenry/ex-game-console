defmodule GameConsoleWeb.PlayerController do
  use GameConsoleWeb.Web, :controller

  def new(conn, _params) do
    render conn, "new.html", player_count: GameConsole.PlayerCountHandler.count, player_statuses: fetch_player_statuses
  end

  def create(conn, %{"player" => params}) do
    :ok = GameConsole.Router.dispatch(struct(GameConsole.CreatePlayer, name: params["name"]))
    redirect conn, to: player_path(conn, :new)
  end

  defp fetch_player_statuses do
    GameConsolePresentation.PlayerStatus
    |> GameConsolePresentation.Repo.all
  end
end
