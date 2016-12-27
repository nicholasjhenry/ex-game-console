defmodule GameConsole.Player do
  alias GameConsole.{PlayerCreated, PlayerHit}

  defstruct name: "Unknown", health: 100

  # public command API

  def create(_, name) do
    DisplayHelper.write_line("#{name} created")
    %PlayerCreated{name: name}
  end

  def hit(_, damage) do
    DisplayHelper.write_line("#{damage} hit")
    %PlayerHit{damage_taken: damage}
  end

  # state mutators

  def apply(%__MODULE__{} = player, %PlayerCreated{name: name}) do
    %__MODULE__{player | name: name}
  end

  def apply(%__MODULE__{} = player, %PlayerHit{damage_taken: damage_taken}) do
    %__MODULE__{player | health: player.health - damage_taken}
  end
end

