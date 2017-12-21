defmodule FacioApi.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing, type: :uuid)

      timestamps()
    end
    create index(:projects, [:user_id])

  end
end
