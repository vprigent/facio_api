defmodule FacioApi.Repo.Migrations.AddProjectToLists do
  use Ecto.Migration

  def change do
    alter table(:lists) do
      add :project_id, references(:projects, on_delete: :nothing, type: :uuid)
    end
    create index(:lists, [:project_id])
  end
end
