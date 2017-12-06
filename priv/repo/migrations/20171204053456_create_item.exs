defmodule FacioApi.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :label, :string
      add :description, :text
      add :value, :integer
      add :list, references(:lists, on_delete: :nothing)

      timestamps()
    end
    create index(:items, [:list])

  end
end
