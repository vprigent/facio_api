defmodule FacioApi.ListView do
  use FacioApi.Web, :view

  def render("index.json", %{lists: lists}) do
    %{
      lists: Enum.map(lists, &list_json/1)
    }
  end

  def render("show.json", %{list: list}) do
    %{
      list: list_json(list)
    }
  end

  defp list_json(list) do
    %{
      id: list.id,
      title: list.title,
      inserted_at: list.inserted_at,
      updated_at: list.updated_at
    }
  end
end
