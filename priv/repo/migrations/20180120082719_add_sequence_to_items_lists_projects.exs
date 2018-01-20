defmodule FacioApi.Repo.Migrations.AddSequenceToItemsListsProjects do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :sequence, :integer
    end
    
    alter table(:lists) do
      add :sequence, :integer
    end

    alter table(:projects) do
      add :sequence, :integer
    end
  end
end
