defmodule GameConsole.Player do
  alias GameConsole.{PlayerCreated, PlayerHit}

  @initial_health 100

  defstruct name: :unknown, health: @initial_health

  # public command API

  def create(%{name: :unknown}, name) do
    %PlayerCreated{name: name, health: @initial_health}
  end
  def create(_player, _name), do: {:error, :player_exists_with_name}

  def hit(_, damage) do
    %PlayerHit{damage_taken: damage}
  end

  # state mutators

  def apply(%__MODULE__{} = player, %PlayerCreated{name: name, health: health}) do
    %{player | name: name, health: health}
  end

  def apply(%__MODULE__{} = player, %PlayerHit{damage_taken: damage_taken}) do
    %{player | health: player.health - damage_taken}
  end
end

