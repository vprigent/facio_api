defmodule FacioApi.PageController do
  use FacioApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
