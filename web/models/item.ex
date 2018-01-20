defmodule FacioApi.Item do
  use FacioApi.Web, :model

  schema "items" do
    field :label, :string
    field :description, :string
    field :value, :integer
    field :sequence, :integer
    field :done_at, :utc_datetime
    belongs_to :list, FacioApi.List

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:label, :description, :value, :list_id])
    |> validate_required([:label, :list_id])
    |> validate_length(:label, min: 2, max: 40)
    |> validate_number(:value, less_than: 6)
  end
end
