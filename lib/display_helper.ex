defmodule DisplayHelper do
  def write_line(string) when is_binary(string) do
    IO.puts string
  end
end
