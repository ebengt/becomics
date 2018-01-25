defmodule BecomicsWeb.ComicView do
  use BecomicsWeb, :view
  alias BecomicsWeb.ComicView

  def render("index.json", %{comics: comics}) do
    %{data: render_many(comics, ComicView, "comic.json")}
  end

  def render("show.json", %{comic: comic}) do
    %{data: render_one(comic, ComicView, "comic.json")}
  end

  def render("comic.json", %{comic: comic}) do
    %{id: comic.id,
      name: comic.name,
      url: comic.url}
  end
end
