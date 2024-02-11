defmodule BecomicsWeb.ComicController do
  use BecomicsWeb, :controller

  action_fallback BecomicsWeb.FallbackController

  def index(conn, _params) do
    comics = Becomics.list_comics()
    render(conn, :index, comics: comics)
  end

  def create(conn, %{"comic" => comic_params}) do
    with {:ok, %Becomics.Comic{} = comic} <- Becomics.create_comic(comic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/comic/#{comic}")
      |> render(:show, comic: comic)
    end
  end

  def show(conn, %{"id" => id}) do
    comic = Becomics.get_comic!(id)
    render(conn, :show, comic: comic)
  end

  def update(conn, %{"id" => id, "comic" => comic_params}) do
    comic = Becomics.get_comic!(id)

    with {:ok, %Becomics.Comic{} = comic} <- Becomics.update_comic(comic, comic_params) do
      render(conn, :show, comic: comic)
    end
  end

  def delete(conn, %{"id" => id}) do
    comic = Becomics.get_comic!(id)

    with {:ok, %Becomics.Comic{}} <- Becomics.delete_comic(comic) do
      send_resp(conn, :no_content, "")
    end
  end
end
