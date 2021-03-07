defmodule BecomicsWeb.PublishControllerTest do
  use BecomicsWeb.ConnCase

  alias Becomics.Comics
  alias Becomics.Comics.Publish

  @create_attrs %{day: "some day"}
  @update_attrs %{day: "some updated day"}
  @invalid_attrs %{day: nil}

  def fixture(:publish) do
    {:ok, publish} = Comics.create_publish(@create_attrs)
    publish
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all publishes", %{conn: conn} do
      conn = get(conn, BecomicsWeb.Router.Helpers.publish_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create publish" do
    test "renders publish when data is valid", %{conn: conn} do
      conn = post conn, Routes.publish_path(conn, :create), publish: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.publish_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "day" => "some day",
               "comic_id" => nil
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.publish_path(conn, :create), publish: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update publish" do
    setup [:create_publish]

    test "renders publish when data is valid", %{conn: conn, publish: %Publish{id: id} = publish} do
      conn = put conn, Routes.publish_path(conn, :update, publish), publish: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.publish_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "day" => "some updated day",
               "comic_id" => nil
             }
    end

    test "renders errors when data is invalid", %{conn: conn, publish: publish} do
      conn = put conn, Routes.publish_path(conn, :update, publish), publish: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete publish" do
    setup [:create_publish]

    test "deletes chosen publish", %{conn: conn, publish: publish} do
      conn = delete(conn, Routes.publish_path(conn, :delete, publish))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.publish_path(conn, :show, publish))
      end
    end
  end

  defp create_publish(_) do
    publish = fixture(:publish)
    {:ok, publish: publish}
  end
end
