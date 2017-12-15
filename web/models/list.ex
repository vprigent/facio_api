defmodule FacioApi.List do
  use FacioApi.Web, :model

  alias FacioApi.List
  alias FacioApi.Repo

  schema "lists" do
    field :title, :string
    belongs_to :user, Authable.Model.User

    timestamps()
  end

  def for_user(user) do
    List
    |> join(:inner, [l], u in assoc(l, :user))
    |> where([l, u], l.user_id == ^user.id)
    |> Repo.all()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :user_id])
    |> validate_required([:title, :user_id])
    |> validate_length(:title, min: 3, max: 40)
  end
end
