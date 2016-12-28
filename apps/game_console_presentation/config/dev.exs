use Mix.Config

config :logger, :console, format: "[$level] $message\n"

# Configure your database
config :game_console_presentation, GameConsolePresentation.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "game_console_dev",
  hostname: "localhost",
  pool_size: 20
