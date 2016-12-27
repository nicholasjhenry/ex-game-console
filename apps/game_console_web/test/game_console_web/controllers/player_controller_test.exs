defmodule GameConsoleWeb.PlayerControllerTest do
  use GameConsoleWeb.ConnCase

  test "rendering a new player form", %{conn: conn} do
    conn = get conn, player_path(conn, :new)
    assert html_response(conn, 200) =~ "Add a new player"
  end

  test "creating a new player", %{conn: conn} do
    attrs = %{name: "henry"}
    conn = post conn, player_path(conn, :create), %{player: attrs}

    assert redirected_to(conn, 302)
  end
end
