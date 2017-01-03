use Mix.Config

config :logger, level: :warn

config :eventstore, EventStore.Storage,
  serializer: JsonSerializer,
  database: "game_console_test",
  hostname: "localhost",
  pool_size: 10,
  extensions: [{Postgrex.Extensions.Calendar, []}]

config :game_console, GameConsole.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "game_console_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
