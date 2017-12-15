defmodule FacioApi.ListController do
  use FacioApi.Web, :controller
  alias FacioApi.List

  plug Authable.Plug.Authenticate, [scopes: ~w(read write)]

  def create(conn, %{"list" => list_params}) do
    list_params =
      list_params
      |> Map.put("user_id", conn.assigns[:current_user].id)

    changeset = List.changeset(%List{}, list_params)

    case Repo.insert(changeset) do

      {:ok, list} ->
        conn
        |> put_status(:created)
        |> render("show.json", list: list)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FacioApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def index(conn, _params) do
    lists = Repo.all(List)
    render conn, "index.json", lists: lists
  end

  def show(conn, %{"id" => id}) do
    list = Repo.get(List, id)
    render conn, "show.json", list: list
  end
end
