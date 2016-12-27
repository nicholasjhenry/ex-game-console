defmodule DisplayHelper do
  def write_line(string) when is_binary(string) do
    unless Mix.env == :test do
      IO.puts(string)
    end
  end
end
