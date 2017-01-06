defmodule GameConsoleWeb.NotificationChannel do
  use Phoenix.Channel

  intercept ["player_hit"]

  def join("notifications", _message, socket) do
    {:ok, socket}
  end

 def handle_out("player_hit", payload, socket) do
    IO.inspect payload
    if payload.hitter == socket.assigns.identity do
      push socket, "player_hit", payload
    end
    {:noreply, socket}
  end
end
