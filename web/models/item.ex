defmodule FacioApi.Item do
  use FacioApi.Web, :model

  schema "items" do
    field :label, :string
    field :description, :string
    field :value, :integer
    belongs_to :list, FacioApi.List

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:label, :description, :value])
    |> validate_required([:label])
    |> validate_length(:label, min: 2, max: 40)
    |> validate_number(:value, less_than: 6)
  end
end
