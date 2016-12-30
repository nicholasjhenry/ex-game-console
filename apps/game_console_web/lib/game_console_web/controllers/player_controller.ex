defmodule GameConsoleWeb.PlayerController do
  use GameConsoleWeb.Web, :controller

  alias GameConsolePresentation.{ActivePlayers, ActivePlayer, PlayerCounter}

  def new(conn, _params) do
    render conn, "new.html", player_count: PlayerCounter.count, active_players: fetch_active_players
  end

  def create(conn, %{"player" => params}) do
    :ok = GameConsole.Router.dispatch(struct(GameConsole.RegisterPlayer, name: params["name"]))
    redirect conn, to: player_path(conn, :new)
  end

  def show(conn, %{"id" => player_id}) do
    render conn, "show.html", player: fetch_active_player(player_id)
  end

  defp fetch_active_players do
    GameConsolePresentation.Repo.all(ActivePlayers)
  end

  defp fetch_active_player(player_id) do
    GameConsolePresentation.Repo.get_by(ActivePlayer, name: player_id)
  end
end
