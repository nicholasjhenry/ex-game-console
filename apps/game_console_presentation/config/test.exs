use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :game_console_presentation, GameConsolePresentation.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "game_console_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
