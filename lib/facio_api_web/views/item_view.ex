defmodule FacioApiWeb.ItemView do
  use FacioApi.Web, :view

  def render("index.json", %{items: items}) do
    %{data: render_many(items, FacioApiWeb.ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, FacioApiWeb.ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{ id: item.id,
      label: item.label,
      done: item.done_at != nil,
      sequence: item.sequence,
      description: item.description,
      inserted_at: item.inserted_at,
      updated_at: item.updated_at,
      list_id: item.list_id }
  end
end
