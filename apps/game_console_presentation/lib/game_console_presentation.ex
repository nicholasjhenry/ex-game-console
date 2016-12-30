defmodule GameConsolePresentation do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    alias GameConsolePresentation.{PlayerCounter, ActivePlayers, ActivePlayer}

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: GameConsolePresentation.Worker.start_link(arg1, arg2, arg3)
      # worker(GameConsolePresentation.Worker, [arg1, arg2, arg3]),
      supervisor(GameConsolePresentation.Repo, []),
      worker(GameConsolePresentation.PlayerCounter, []),
      worker(Commanded.Event.Handler, ["player_counter", PlayerCounter, [start_from: :current]], id: :player_counter),
      worker(Commanded.Event.Handler, ["active_players", ActivePlayers.Projector], id: :active_players),
      worker(Commanded.Event.Handler, ["active_player", ActivePlayer.Projector], id: :active_player)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GameConsolePresentation.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
