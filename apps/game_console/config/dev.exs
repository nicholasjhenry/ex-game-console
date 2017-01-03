use Mix.Config

config :eventstore, EventStore.Storage,
  serializer: JsonSerializer,
  database: "game_console_dev",
  hostname: "localhost",
  pool_size: 10,
  extensions: [{Postgrex.Extensions.Calendar, []}]

config :game_console, GameConsole.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "game_console_dev",
  hostname: "localhost",
  pool_size: 20
