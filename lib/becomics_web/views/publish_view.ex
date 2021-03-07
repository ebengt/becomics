defmodule BecomicsWeb.PublishView do
  use BecomicsWeb, :view
  alias BecomicsWeb.PublishView

  def render("index.json", %{publishes: publishes}) do
    %{data: render_many(publishes, PublishView, "publish.json")}
  end

  def render("show.json", %{publish: publish}) do
    %{data: render_one(publish, PublishView, "publish.json")}
  end

  def render("publish.json", %{publish: publish}) do
    %{id: publish.id, day: publish.day, comic_id: publish.comic_id}
  end
end
