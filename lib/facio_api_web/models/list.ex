defmodule FacioApiWeb.List do
  import Ecto.Query, only: [from: 2]
  use FacioApi.Web, :model

  alias FacioApiWeb.List
  alias FacioApiWeb.Item
  alias FacioApiWeb.Repo

  schema "lists" do
    field :title, :string
    field :sequence, :integer
    belongs_to :user, Authable.Model.User
    belongs_to :project, FacioApiWeb.Project

    has_many :items, Item

    timestamps()
  end

  def for_user(user) do
    List
    |> join(:inner, [l], u in assoc(l, :user))
    |> where([l, u], l.user_id == ^user.id)
    |> Repo.all()
  end

  def update_sequence(item) do
    # items = Item
    #   |> select fragment("row_number() AS row")
    #   |> where([i, l], i.list_id == ^item.list.id)
    #   |> order_by([asc: :sequence, desc: :updated_at])
    #   |> Repo.all()
      #   Repo.get(List, item.list.id)
      # |> Repo.preload([items: (from i in Item, order_by: i.sequence, i.updated_at)])


    # IO.inspect items
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :user_id, :project_id, :sequence])
    |> validate_required([:title, :user_id, :project_id])
    |> validate_length(:title, min: 3, max: 40)
  end
end
