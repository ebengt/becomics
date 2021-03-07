defmodule BecomicsWeb.PageController do
  use BecomicsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
