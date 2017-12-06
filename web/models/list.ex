defmodule FacioApi.List do
  use FacioApi.Web, :model

  schema "lists" do
    field :title, :string
    belongs_to :user, Authable.Model.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title, :user])
    |> validate_length(:title, min: 3, max: 40)
  end
end
