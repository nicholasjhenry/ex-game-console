defmodule JsonSerializer do
  @moduledoc """
  A serializer that uses the JSON format.
  """

  @behaviour EventStore.Serializer

  @doc """
  Serialize given term to JSON binary data.
  """
  def serialize(term) do
    Poison.encode!(term)
  end

  @doc """
  Deserialize given JSON binary data to the expected type.
  """
  def deserialize(binary, config) do
    type = case Keyword.get(config, :type, nil) do
      nil -> []
      type -> type |> String.to_atom |> to_module |> struct
    end
    Poison.decode!(binary, as: type)
  end

  defp to_module(atom) do
    Module.concat(Elixir, atom)
  end
end
