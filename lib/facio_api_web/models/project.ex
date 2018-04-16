defmodule FacioApiWeb.Project do
  use FacioApi.Web, :model

  alias FacioApiWeb.Project
  alias FacioApiWeb.Repo

  schema "projects" do
    field :name, :string
    field :sequence, :integer

    belongs_to :user, Authable.Model.User
    has_many :lists, FacioApiWeb.List

    timestamps()
  end

  def for_user(user) do
    Project
    |> join(:inner, [p], u in assoc(p, :user))
    |> where([p, u], p.user_id == ^user.id)
    |> Repo.all()
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :sequence, :user_id])
    |> validate_required([:name])
  end
end
