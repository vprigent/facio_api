defmodule FacioApiWeb.TagController do
  use FacioApi.Web, :controller

  alias FacioApiWeb.Tag

  plug Authable.Plug.Authenticate, [scopes: ~w(read write)]

  def index(conn, _params) do
    render conn, "index.json", tags: Repo.all(Tag)
  end

  def create(conn, %{"tag" => tag_params}) do
    changeset = Tag.changeset(%Tag{}, tag_params)

    case Repo.insert(changeset) do
      {:ok, tag} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", tag_path(conn, :show, tag))
        |> render("show.json", tag: tag)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FacioApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    case Repo.get!(Tag, id) do
      {:ok, tag} ->
        render conn, "show.json", tag: tag
      {:error} ->
        conn
        |> put_status(:not_found)
        |> render(FacioApi.ErrorView, "404.json")
    end
  end

  def delete(conn, %{"id" => id}) do

    if (tag = Repo.get(Tag, id)) && Repo.delete!(tag) do
      conn
      |> send_resp(:ok, id)
    else
      conn
      |> put_status(:not_found)
      |> render(FacioApi.ErrorView, "404.json")
    end
  end
end
