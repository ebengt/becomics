defmodule Becomics.ComicsTest do
  use Becomics.DataCase

  describe "comics" do
    import Becomics.ComicsFixtures

    @invalid_attrs %{name: nil, url: nil}

    test "list_comics/0 returns all comics" do
      comic = comic_fixture()
      assert Becomics.list_comics() == [comic]
    end

    test "get_comic!/1 returns the comic with given id" do
      comic = comic_fixture()
      assert Becomics.get_comic!(comic.id) == comic
    end

    test "create_comic/1 with valid data creates a comic" do
      valid_attrs = %{name: "some name", url: "http://some url"}

      assert {:ok, %Becomics.Comic{} = comic} = Becomics.create_comic(valid_attrs)
      assert comic.name == "some name"
      assert comic.url == "http://some url"
    end

    test "create_comic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Becomics.create_comic(@invalid_attrs)
    end

    test "update_comic/2 with valid data updates the comic" do
      comic = comic_fixture()
      update_attrs = %{name: "some updated name", url: "http://some updated url"}

      assert {:ok, %Becomics.Comic{} = comic} = Becomics.update_comic(comic, update_attrs)
      assert comic.name == "some updated name"
      assert comic.url == "http://some updated url"
    end

    test "update_comic/2 with invalid data returns error changeset" do
      comic = comic_fixture()
      assert {:error, %Ecto.Changeset{}} = Becomics.update_comic(comic, @invalid_attrs)
      assert comic == Becomics.get_comic!(comic.id)
    end

    test "delete_comic/1 deletes the comic" do
      comic = comic_fixture()
      assert {:ok, %Becomics.Comic{}} = Becomics.delete_comic(comic)
      assert_raise Ecto.NoResultsError, fn -> Becomics.get_comic!(comic.id) end
    end

    test "change_comic/1 returns a comic changeset" do
      comic = comic_fixture()
      assert %Ecto.Changeset{} = Becomics.change_comic(comic)
    end
  end
end
