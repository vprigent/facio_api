defmodule FacioApi.ItemController do
  use FacioApi.Web, :controller
  alias FacioApi.Item
  alias FacioApi.List

  plug Authable.Plug.Authenticate, [scopes: ~w(read write)]

  def index(conn, %{"list_id" => list_id}) do
    current_user = conn.assigns[:current_user]

    list = Repo.get(List, list_id) |> Repo.preload(:items)

    if list && list.user_id == current_user.id do
      items = list.items
      render conn, "index.json", items: items
    else
      conn
      |> put_status(:forbidden)
      |> render(FacioApi.ErrorView, "403.json")
    end
  end

  def create(conn, %{"item" => item_params}) do

    changeset = Item.changeset(%Item{}, item_params)

    case Repo.insert(changeset) do
      {:ok, item} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", item_path(conn, :show, item))
        |> render("show.json", item: item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FacioApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns[:current_user]

    item = Repo.get(Item, id) |> preload(:list)

    if item.list.user_id == current_user.id do
      render conn, "show.json", item: item
    else
      conn
      |> put_status(:forbidden)
      |> render(FacioApi.ErrorView, "403.json")
    end
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Repo.get!(Item, id)
    changeset = Item.changeset(item, item_params)

    case Repo.update(changeset) do
      {:ok, item} ->
        render(conn, "show.json", item: item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FacioApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do

    if (item = Repo.get(Item, id)) && Repo.delete!(item) do
      conn
      |> send_resp(:ok, "")
    else
      conn
      |> put_status(:not_found)
      |> render(FacioApi.ErrorView, "404.json")
    end
  end
end
