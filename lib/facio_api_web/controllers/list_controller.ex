defmodule FacioApiWeb.ListController do
  use FacioApi.Web, :controller

  alias FacioApiWeb.List

  plug Authable.Plug.Authenticate, [scopes: ~w(read write)]

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]

    lists = List.for_user(current_user) |> Repo.preload(:items)

    render conn, "index_with_items.json", lists: lists
  end

  def create(conn, %{"list" => list_params}) do
    list_params =
      list_params
      |> Map.put("user_id", conn.assigns[:current_user].id)

    changeset = List.changeset(%List{}, list_params)

    case Repo.insert(changeset) do
      {:ok, list} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", list_path(conn, :show, list))
        |> render("show.json", list: list)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FacioApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns[:current_user]

    list = Repo.get(List, id)

    if list.user_id == current_user.id do
      render conn, "show.json", list: list
    else
      conn
      |> put_status(:forbidden)
      |> render(FacioApiWeb.ErrorView, "403.json")
    end
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    current_user = conn.assigns[:current_user]

    list = Repo.get(List, id)

    if list.user_id == current_user.id do

      changeset = List.changeset(list, list_params)

      case Repo.update(changeset) do
        {:ok, list} ->
          render(conn, "show.json", list: list)
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(FacioApiWeb.ChangesetView, "error.json", changeset: changeset)
      end
    else
      conn
      |> put_status(:forbidden)
      |> render(FacioApiWeb.ErrorView, "403.json")
    end
  end

  def delete(conn, %{"id" => id}) do

    if (list = Repo.get(List, id)) && Repo.delete!(list) do
      conn
      |> send_resp(:ok, "")
    else
      conn
      |> put_status(:not_found)
      |> render(FacioApiWeb.ErrorView, "404.json")
    end
  end
end
