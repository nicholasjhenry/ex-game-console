defmodule GameConsolePresentation.SocketBroadcaster do
  @behaviour Commanded.Event.Handler

  def handle(%GameConsole.PlayerRegistered{} = player, _) do
    GameConsoleWeb.Endpoint.broadcast("notifications", "player_registered", Map.take(player, [:name, :health]))
  end

  def handle(%GameConsole.PlayerHit{} = player, _) do
    GameConsoleWeb.Endpoint.broadcast("notifications", "player_hit", Map.take(player, [:name, :hitter, :damage_taken, :remaining_health]))
  end

  def handle(_event, _metadata), do: :ok
end
