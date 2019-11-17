defmodule FacioApi.Repo.Migrations.CreateItemsTagsJoinTable do
  use Ecto.Migration

  def change do
    create table(:items_tags, primary_key: false) do
      add :item_id, references(:items, type: :uuid)
      add :tag_id, references(:tags, type: :uuid)
    end
  end
end
