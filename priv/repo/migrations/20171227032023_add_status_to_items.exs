defmodule FacioApi.Repo.Migrations.AddStatusToItems do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :done_at, :utc_datetime
    end
  end
end
