defmodule BecomicsWeb.PublishController do
  use BecomicsWeb, :controller

  alias Becomics.Comics
  alias Becomics.Comics.Publish

  action_fallback BecomicsWeb.FallbackController

  def index(conn, _params) do
    publishes = Comics.list_publishes()
    render(conn, "index.json", publishes: publishes)
  end

  def create(conn, %{"publish" => publish_params}) do
    with {:ok, %Publish{} = publish} <- Comics.create_publish(publish_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        BecomicsWeb.Router.Helpers.publish_path(conn, :show, publish)
      )
      |> render("show.json", publish: publish)
    end
  end

  def show(conn, %{"id" => id}) do
    publish = Comics.get_publish!(id)
    render(conn, "show.json", publish: publish)
  end

  def update(conn, %{"id" => id, "publish" => publish_params}) do
    publish = Comics.get_publish!(id)

    with {:ok, %Publish{} = publish} <- Comics.update_publish(publish, publish_params) do
      render(conn, "show.json", publish: publish)
    end
  end

  def delete(conn, %{"id" => id}) do
    publish = Comics.get_publish!(id)

    with {:ok, %Publish{}} <- Comics.delete_publish(publish) do
      send_resp(conn, :no_content, "")
    end
  end
end
