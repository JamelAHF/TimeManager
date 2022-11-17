defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :password, :string, null: false
      add :email, :string
      add :team_id, references(:teams, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)
    end
    create unique_index(:users, :email)
    create unique_index(:users, :username)

  end
end
