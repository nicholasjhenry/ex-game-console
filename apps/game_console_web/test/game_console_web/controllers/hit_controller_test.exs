defmodule GameConsoleWeb.HitControllerTest do
  use GameConsoleWeb.ConnCase
  import Commanded.Assertions.EventAssertions

  alias GameConsole.{RegisterPlayer, PlayerRegistered, Router}

  test "hitting a player", %{conn: conn} do
    :ok = Router.dispatch(%RegisterPlayer{name: "danny"})
    wait_for_event(PlayerRegistered)

    conn = post conn, player_hit_path(conn, :create, "danny"), hit: %{damage: "100"}

    assert redirected_to(conn, 302) == player_path(conn, :show, "danny")
  end
end
