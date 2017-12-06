defmodule FacioApi.Repo.Migrations.AddUsersToLists do
  use Ecto.Migration

  def change do
    alter table(:lists) do
      add :user, references(:users, on_delete: :nothing, type: :uuid)
    end
    create index(:lists, [:user])
  end
end
