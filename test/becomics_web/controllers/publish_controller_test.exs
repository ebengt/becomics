defmodule BecomicsWeb.PublishControllerTest do
  use BecomicsWeb.ConnCase

  import Becomics.PublishesFixtures

  @create_attrs %{
    day: "some day"
  }
  @update_attrs %{
    day: "some updated day"
  }
  @invalid_attrs %{day: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all publishes", %{conn: conn} do
      conn = get(conn, ~p"/api/publish")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create publish" do
    test "renders publish when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/publish", publish: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/publish/#{id}")

      assert %{
               "id" => ^id,
               "day" => "some day"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/publish", publish: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update publish" do
    setup [:create_publish]

    test "renders publish when data is valid", %{
      conn: conn,
      publish: %Becomics.Publish{id: id} = publish
    } do
      conn = put(conn, ~p"/api/publish/#{publish}", publish: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/publish/#{id}")

      assert %{
               "id" => ^id,
               "day" => "some updated day"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, publish: publish} do
      conn = put(conn, ~p"/api/publish/#{publish}", publish: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete publish" do
    setup [:create_publish]

    test "deletes chosen publish", %{conn: conn, publish: publish} do
      conn = delete(conn, ~p"/api/publish/#{publish}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/publish/#{publish}")
      end
    end
  end

  defp create_publish(_) do
    publish = publish_fixture()
    %{publish: publish}
  end
end
