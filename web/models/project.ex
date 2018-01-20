defmodule FacioApi.Project do
  use FacioApi.Web, :model
  alias FacioApi.Project
  alias FacioApi.Repo


  schema "projects" do
    field :name, :string
    field :sequence, :integer

    belongs_to :user, Authable.Model.User
    has_many :lists, FacioApi.List

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
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
