defmodule GameConsole.PlayerCounter do
  @behaviour Commanded.Event.Handler

  alias GameConsole.PlayerRegistered

  def start_link do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  def handle(%PlayerRegistered{}, _metadata) do
    Agent.update(__MODULE__, fn count -> count + 1 end)
  end

  # ignore all other events
  def handle(_event, _metadata), do: :ok

  def count do
    Agent.get(__MODULE__, fn count -> count end)
  end

  def reset do
    Agent.update(__MODULE__, fn(_) -> 0 end)
  end
end
