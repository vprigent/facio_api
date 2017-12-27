defmodule FacioApi.ItemView do
  use FacioApi.Web, :view

  def render("index.json", %{items: items}) do
    %{
      items: Enum.map(items, &item_json/1)
    }
  end

  def render("show.json", %{item: item}) do
    %{
      item: item_json(item)
    }
  end

  defp item_json(item) do
    %{
      id: item.id,
      label: item.label,
      done: item.done_at,
      description: item.description,
      inserted_at: item.inserted_at,
      updated_at: item.updated_at
    }
  end
end
