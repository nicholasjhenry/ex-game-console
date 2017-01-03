defmodule GameConsole.Case do
  use ExUnit.CaseTemplate

  setup tags do
    {:ok, pid} = Postgrex.start_link(
      hostname: Application.get_env(:eventstore, EventStore.Storage)[:hostname],
      database: Application.get_env(:eventstore, EventStore.Storage)[:database]
    )
    Postgrex.query!(pid, "DELETE FROM events", [])
    Postgrex.query!(pid, "DELETE FROM snapshots", [])
    Postgrex.query!(pid, "DELETE FROM streams", [])
    Postgrex.query!(pid, "DELETE FROM subscriptions", [])
    Postgrex.query!(pid, "DELETE FROM active_player", [])

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GameConsole.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(GameConsole.Repo, {:shared, self()})
    end

    {:ok, [event_store_pid: pid]}
  end
end
