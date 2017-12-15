defmodule FacioApi.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :label, :string
      add :description, :text
      add :value, :integer
      add :list, references(:lists, on_delete: :nothing, type: :uuid)

      timestamps()
    end
    create index(:items, [:list])

  end
end
