defmodule FacioApi.ProjectView do
  use FacioApi.Web, :view

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, FacioApi.ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, FacioApi.ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      name: project.name,
      sequence: project.sequence}
  end
end
