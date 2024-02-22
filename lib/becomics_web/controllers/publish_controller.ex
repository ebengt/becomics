defmodule BecomicsWeb.PublishController do
  use BecomicsWeb, :controller

  action_fallback BecomicsWeb.FallbackController

  def index(conn, _params) do
    publishes = Becomics.list_publishes()
    render(conn, :index, publishes: publishes)
  end

  def create(conn, %{"publish" => publish_params}) do
    with {:ok, %Becomics.Publish{} = publish} <- Becomics.create_publish(publish_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/publish/#{publish}")
      |> render(:show, publish: publish)
    end
  end

  def show(conn, %{"id" => id}) do
    publish = Becomics.get_publish!(id)
    render(conn, :show, publish: publish)
  end

  def update(conn, %{"id" => id, "publish" => publish_params}) do
    publish = Becomics.get_publish!(id)

    with {:ok, %Becomics.Publish{} = publish} <- Becomics.update_publish(publish, publish_params) do
      render(conn, :show, publish: publish)
    end
  end

  def delete(conn, %{"id" => id}) do
    publish = Becomics.get_publish!(id)

    with {:ok, %Becomics.Publish{}} <- Becomics.delete_publish(publish) do
      send_resp(conn, :no_content, "")
    end
  end
end
