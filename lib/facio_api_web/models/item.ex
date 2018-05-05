defmodule FacioApiWeb.Item do
  use FacioApi.Web, :model

  schema "items" do
    field :label, :string
    field :description, :string
    field :value, :integer
    field :sequence, :integer
    field :done, :boolean, virtual: true
    field :done_at, :utc_datetime
    belongs_to :list, FacioApi.List

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:label, :description, :value, :done, :list_id, :sequence])
    |> validate_required([:label, :list_id])
    |> validate_length(:label, min: 2, max: 40)
    |> validate_number(:value, less_than: 6)
    |> cast_done
  end

  defp cast_done(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{done: done}} ->
        put_change(changeset, :done_at, DateTime.utc_now)
      _ ->
        changeset
    end
  end
end
