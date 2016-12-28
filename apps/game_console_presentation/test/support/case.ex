defmodule GameConsolePresentation.Case do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias GameConsolePresentation.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import GameConsolePresentation.Case
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GameConsolePresentation.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(GameConsolePresentation.Repo, {:shared, self()})
    end

    :ok
  end
end
