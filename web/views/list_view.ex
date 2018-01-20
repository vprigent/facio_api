defmodule FacioApi.ListView do
  use FacioApi.Web, :view

  def render("index.json", %{lists: lists}) do
    %{data: render_many(lists, FacioApi.ListView, "list.json")}
  end

  def render("show.json", %{list: list}) do
    %{data: render_one(list, FacioApi.ListView, "list.json")}
  end

  def render("list.json", %{list: list}) do
    %{ id: list.id,
      title: list.title,
      sequence: list.sequence,
      project_id: list.project_id }
  end
end
