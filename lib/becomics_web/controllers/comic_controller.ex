defmodule BecomicsWeb.ComicController do
  use BecomicsWeb, :controller

  alias Becomics.Comics
  alias Becomics.Comics.Comic

  action_fallback BecomicsWeb.FallbackController

  def index(conn, _params) do
    comics = Comics.list_comics()
    render(conn, "index.json", comics: comics)
  end

  def create(conn, %{"comic" => comic_params}) do
    with {:ok, %Comic{} = comic} <- Comics.create_comic(comic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", BecomicsWeb.Router.Helpers.comic_path(conn, :show, comic))
      |> render("show.json", comic: comic)
    end
  end

  def show(conn, %{"id" => id}) do
    comic = Comics.get_comic!(id)
    render(conn, "show.json", comic: comic)
  end

  def update(conn, %{"id" => id, "comic" => comic_params}) do
    comic = Comics.get_comic!(id)

    with {:ok, %Comic{} = comic} <- Comics.update_comic(comic, comic_params) do
      render(conn, "show.json", comic: comic)
    end
  end

  def delete(conn, %{"id" => id}) do
    comic = Comics.get_comic!(id)

    with {:ok, %Comic{}} <- Comics.delete_comic(comic) do
      send_resp(conn, :no_content, "")
    end
  end
end
