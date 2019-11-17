defmodule FacioApiWeb.Tag do
  import Ecto.Query, only: [from: 2]
  use FacioApi.Web, :model

  alias FacioApiWeb.Tag
  alias FacioApiWeb.Repo

  schema "tags" do
    field :name, :string
    many_to_many :items, FacioApiWeb.Item, join_through: "items_tags"

    timestamps()
  end

  def find_or_create(params \\ []) do
    # params = Enum.each params, fn {k, v} ->
    case Repo.one(Tag, params) do
      nil ->
        Tag.changeset(%Tag{}, %{"tag" => params})
        |> Repo.insert
      tag ->
        tag
    end
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
