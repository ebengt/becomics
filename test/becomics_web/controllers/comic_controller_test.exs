defmodule BecomicsWeb.ComicControllerTest do
  use BecomicsWeb.ConnCase

  import Becomics.ComicsFixtures

  @create_attrs %{
    name: "some name",
    url: "http://some url"
  }
  @update_attrs %{
    name: "some updated name",
    url: "http://some updated url"
  }
  @invalid_attrs %{name: nil, url: "no url"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all comics", %{conn: conn} do
      conn = get(conn, ~p"/api/comic")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create comic" do
    test "renders comic when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/comic", comic: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/comic/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name",
               "url" => "http://some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/comic", comic: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update comic" do
    setup [:create_comic]

    test "renders comic when data is valid", %{conn: conn, comic: %Becomics.Comic{id: id} = comic} do
      conn = put(conn, ~p"/api/comic/#{comic}", comic: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/comic/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "url" => "http://some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, comic: comic} do
      conn = put(conn, ~p"/api/comic/#{comic}", comic: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete comic" do
    setup [:create_comic]

    test "deletes chosen comic", %{conn: conn, comic: comic} do
      conn = delete(conn, ~p"/api/comic/#{comic}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/comic/#{comic}")
      end
    end
  end

  defp create_comic(_) do
    comic = comic_fixture()
    %{comic: comic}
  end
end
