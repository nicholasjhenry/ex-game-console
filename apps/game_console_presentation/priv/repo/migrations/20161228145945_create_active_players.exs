defmodule GameConsolePresentation.Repo.Migrations.CreateActivePlayers do
  use Ecto.Migration

  def change do
    create table(:active_players) do
      add :name, :text, null: false
      add :health, :integer, null: false

      timestamps
    end
  end
end
