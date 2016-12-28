defmodule GameConsolePresentation.Repo.Migrations.CreatePlayerStatuses do
  use Ecto.Migration

  def change do
    create table(:player_statuses) do
      add :name, :text
      add :status, :string, default: "alive"

      timestamps
    end
  end
end
