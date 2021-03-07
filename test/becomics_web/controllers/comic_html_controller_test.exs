defmodule BecomicsWeb.ComicHTMLControllerTest do
  use BecomicsWeb.ConnCase

  @create_attrs %{name: "some name", url: "http://some url"}

  def fixture(:comic) do
    {:ok, comic} = Becomics.Comics.create_comic(@create_attrs)
    comic
  end

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  describe "update comic" do
    setup [:create_comic]

    test "change comic table when data is valid", %{conn: conn, comic: %Becomics.Comics.Comic{id: id}} do
	conn = post conn, Routes.comic_html_path(conn, :update, id), url: "http://some updated url"
	assert conn.status === 200
	comic = Becomics.Comics.get_comic!(id)
	assert comic.url === "http://some updated url"
    end
  end



  defp create_comic(_) do
    comic = fixture(:comic)
    {:ok, comic: comic}
  end
end
