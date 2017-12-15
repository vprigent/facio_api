defmodule FacioApi.Repo.Migrations.AddUsersToLists do
  use Ecto.Migration

  def change do
    alter table(:lists) do
      add :user_id, references(:users, on_delete: :nothing, type: :uuid)
    end
    create index(:lists, [:user_id])
  end
end
