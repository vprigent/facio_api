defmodule FacioApi.ProjectController do
  use FacioApi.Web, :controller
  alias FacioApi.Project

  plug Authable.Plug.Authenticate, [scopes: ~w(read write)]

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]

    projects = Project.for_user(current_user)

    render conn, "index.json", projects: projects
  end

  def create(conn, %{"project" => project_params}) do
    project_params =
      project_params
      |> Map.put("user_id", conn.assigns[:current_user].id)

    changeset = Project.changeset(%Project{}, project_params)

    case Repo.insert(changeset) do
      {:ok, project} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", project_path(conn, :show, project))
        |> render("show.json", project: project)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FacioApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns[:current_user]

    project = Repo.get(Project, id)

    if project.user_id == current_user.id do
      render conn, "show.json", project: project
    else
      conn
      |> put_status(:forbidden)
      |> render(FacioApi.ErrorView, "403.json")
    end
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    current_user = conn.assigns[:current_user]

    project = Repo.get(Project, id)

    if project.user_id == current_user.id do

      changeset = Project.changeset(project, project_params)

      case Repo.update(changeset) do
        {:ok, project} ->
          render(conn, "show.json", project: project)
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(FacioApi.ChangesetView, "error.json", changeset: changeset)
      end
    else
      conn
      |> put_status(:forbidden)
      |> render(FacioApi.ErrorView, "403.json")
    end
  end

  def delete(conn, %{"id" => id}) do
    if (project = Repo.get(Project, id)) && Repo.delete!(project) do
      conn
      |> send_resp(:ok, "")
    else
      conn
      |> put_status(:not_found)
      |> render(FacioApi.ErrorView, "404.json")
    end
  end
end
