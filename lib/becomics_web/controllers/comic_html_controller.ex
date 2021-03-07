defmodule BecomicsWeb.ComicHTMLController do
  use BecomicsWeb, :controller

  action_fallback BecomicsWeb.FallbackController

  def index(conn, _params) do
    # Not working: BecomicsWeb.ComicController.index(conn, params)
    render(conn, "index.html", comics: Becomics.Comics.list_comics())
  end

  def show(conn, %{"day" => day}) do
    comics = BecomicsWeb.ControllersLib.comics(day)
    render(conn, "index.html", comics: comics)
  end

  def update(conn, %{"id" => id, "url" => url}) do
    comic = Becomics.Comics.get_comic!(id)

    with {:ok, %Becomics.Comics.Comic{} = comic} =
           Becomics.Comics.update_comic(comic, %{url: url}) do
      render(conn, "update.html", comic: comic)
    end
  end
end
