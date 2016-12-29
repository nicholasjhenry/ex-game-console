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

  test "showing an active player", %{conn: conn} do
    alias GameConsolePresentation.ActivePlayer
    player = %ActivePlayer{name: "nicholas", health: 100} |> Repo.insert!

    conn = get conn, player_path(conn, :show, player)
    assert html_response(conn, 200) =~ "Active Player"
  end
end
