use Mix.Config

config :logger, level: :warn

config :eventstore, EventStore.Storage,
  serializer: JsonSerializer,
  database: "game_console_test",
  hostname: "localhost",
  pool_size: 10,
  extensions: [{Postgrex.Extensions.Calendar, []}]
