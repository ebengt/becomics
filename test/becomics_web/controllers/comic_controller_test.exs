defmodule BecomicsWeb.ComicControllerTest do
  use BecomicsWeb.ConnCase

  alias Becomics.Comics
  alias Becomics.Comics.Comic

  @create_attrs %{name: "some name", url: "http://some url"}
  @update_attrs %{name: "some updated name", url: "http://some updated url"}
  @invalid_attrs %{name: nil, url: nil}
  @invalid_attrs_url %{name: "some name", url: "some url"}

  def fixture(:comic) do
    {:ok, comic} = Comics.create_comic(@create_attrs)
    comic
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all comics", %{conn: conn} do
      conn = get conn, Routes.comic_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create comic" do
    test "renders comic when data is valid", %{conn: conn} do
      conn = post conn, Routes.comic_path(conn, :create), comic: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, Routes.comic_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "url" => "http://some url"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.comic_path(conn, :create), comic: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update comic" do
    setup [:create_comic]

    test "renders comic when data is valid", %{conn: conn, comic: %Comic{id: id} = comic} do
      conn = put conn, Routes.comic_path(conn, :update, comic), comic: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, Routes.comic_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "url" => "http://some updated url"}
    end

    test "renders errors when data is invalid", %{conn: conn, comic: comic} do
      conn = put conn, Routes.comic_path(conn, :update, comic), comic: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors when url is invalid", %{conn: conn, comic: comic} do
      conn = put conn, Routes.comic_path(conn, :update, comic), comic: @invalid_attrs_url
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete comic" do
    setup [:create_comic]

    test "deletes chosen comic", %{conn: conn, comic: comic} do
      conn = delete conn, Routes.comic_path(conn, :delete, comic)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, Routes.comic_path(conn, :show, comic)
      end
    end
  end

  defp create_comic(_) do
    comic = fixture(:comic)
    {:ok, comic: comic}
  end
end
