defmodule GameConsolePresentation.Repo.Migrations.CreateActivePlayer do
  use Ecto.Migration

  def change do
    create table(:active_player) do
      add :name, :text, null: false
      add :health, :integer, null: false

      timestamps
    end
  end
end
