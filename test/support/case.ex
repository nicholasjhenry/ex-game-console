defmodule GameConsole.Case do
  use ExUnit.CaseTemplate

  setup do
    {:ok, pid} = Postgrex.start_link(
      hostname: Application.get_env(:eventstore, EventStore.Storage)[:hostname],
      database: Application.get_env(:eventstore, EventStore.Storage)[:database]
    )
    Postgrex.query!(pid, "DELETE FROM events", [])
    Postgrex.query!(pid, "DELETE FROM snapshots", [])
    Postgrex.query!(pid, "DELETE FROM streams", [])
    Postgrex.query!(pid, "DELETE FROM subscriptions", [])

    {:ok, [event_store_pid: pid]}
  end
end
