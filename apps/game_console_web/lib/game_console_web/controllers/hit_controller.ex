defmodule GameConsoleWeb.HitController do
  use GameConsoleWeb.Web, :controller

  def create(conn, %{"player_id" => name, "hit" => %{"damage" => damage, "hitter" => hitter}}) do
    {:ok, hitter} = Phoenix.Token.verify(conn, "identity", hitter)
    :ok = GameConsole.Router.dispatch(
      struct(GameConsole.HitPlayer, hitter: hitter, name: name, damage: String.to_integer(damage))
    )
    turbo_redirect conn, to: player_path(conn, :show, name)
  end

  def turbo_redirect(conn, opts) do
    if conn.params["_format"] == "js" do
      to = Keyword.fetch!(opts, :to)
      visit_with_turbolinks(conn, to)
    else
      conn
      |> Phoenix.Controller.redirect(opts)
    end
  end

  defp visit_with_turbolinks(conn, to) do
    script = "Turbolinks.clearCache()\nTurbolinks.visit(#{Poison.encode!(to)})"

    conn
    |> Plug.Conn.put_resp_header("content-type", "text/javascript")
    |> Plug.Conn.send_resp(200, script)
  end
end
