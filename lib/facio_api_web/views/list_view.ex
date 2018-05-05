defmodule FacioApiWeb.ListView do
  use FacioApi.Web, :view

  def render("index.json", %{lists: lists}) do
    %{data: render_many(lists, FacioApiWeb.ListView, "list.json")}
  end

  def render("index_with_items.json", %{lists: lists}) do
    %{data: render_many(lists, FacioApiWeb.ListView, "list_with_items.json")}
  end

  def render("show.json", %{list: list}) do
    %{data: render_one(list, FacioApiWeb.ListView, "list.json")}
  end

  def render("list.json", %{list: list}) do
    %{ id: list.id,
      title: list.title,
      sequence: list.sequence,
      project_id: list.project_id }
  end

  def render("list_with_items.json", %{list: list}) do
    %{ id: list.id,
      title: list.title,
      sequence: list.sequence,
      project_id: list.project_id,
      items: render_many(list.items, FacioApiWeb.ItemView, "item.json")}
  end
end
