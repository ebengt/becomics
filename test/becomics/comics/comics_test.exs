defmodule Becomics.ComicsTest do
  use Becomics.DataCase

  alias Becomics.Comics

  describe "comics" do
    alias Becomics.Comics.Comic

    @valid_attrs %{name: "some name", url: "http://some url"}
    @update_attrs %{name: "some updated name", url: "http://some updated url"}
    @invalid_attrs %{name: nil, url: nil}
    @invalid_attrs_url %{name: "some name", url: "no http"}

    def comic_fixture(attrs \\ %{}) do
      {:ok, comic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Comics.create_comic()

      comic
    end

    test "list_comics/0 returns all comics" do
      comic = comic_fixture()
      assert Comics.list_comics() == [comic]
    end

    test "get_comic!/1 returns the comic with given id" do
      comic = comic_fixture()
      assert Comics.get_comic!(comic.id) == comic
    end

    test "create_comic/1 with valid data creates a comic" do
      assert {:ok, %Comic{} = comic} = Comics.create_comic(@valid_attrs)
      assert comic.name == @valid_attrs.name
      assert comic.url == @valid_attrs.url
    end

    test "create_comic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comics.create_comic(@invalid_attrs)
    end

    test "create_comic/1 with invalid url data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comics.create_comic(@invalid_attrs_url)
    end

    test "update_comic/2 with valid data updates the comic" do
      comic = comic_fixture()
      assert {:ok, comic} = Comics.update_comic(comic, @update_attrs)
      assert %Comic{} = comic
      assert comic.name == @update_attrs.name
      assert comic.url == @update_attrs.url
    end

    test "update_comic/2 with invalid data returns error changeset" do
      comic = comic_fixture()
      assert {:error, %Ecto.Changeset{}} = Comics.update_comic(comic, @invalid_attrs)
      assert comic == Comics.get_comic!(comic.id)
    end

    test "delete_comic/1 deletes the comic" do
      comic = comic_fixture()
      assert {:ok, %Comic{}} = Comics.delete_comic(comic)
      assert_raise Ecto.NoResultsError, fn -> Comics.get_comic!(comic.id) end
    end

    test "change_comic/1 returns a comic changeset" do
      comic = comic_fixture()
      assert %Ecto.Changeset{} = Comics.change_comic(comic)
    end
  end

  describe "publishes" do
    alias Becomics.Comics.Publish

    @valid_attrs %{day: "some day"}
    @update_attrs %{day: "some updated day"}
    @invalid_attrs %{day: nil}

    def publish_fixture(attrs \\ %{}) do
      {:ok, publish} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Comics.create_publish()

      publish
    end

    test "list_publishes/0 returns all publishes" do
      publish = publish_fixture()
      assert Comics.list_publishes() == [publish]
    end

    test "get_publish!/1 returns the publish with given id" do
      publish = publish_fixture()
      assert Comics.get_publish!(publish.id) == publish
    end

    test "create_publish/1 with valid data creates a publish" do
      assert {:ok, %Publish{} = publish} = Comics.create_publish(@valid_attrs)
      assert publish.day == "some day"
    end

    test "create_publish/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comics.create_publish(@invalid_attrs)
    end

    test "update_publish/2 with valid data updates the publish" do
      publish = publish_fixture()
      assert {:ok, publish} = Comics.update_publish(publish, @update_attrs)
      assert %Publish{} = publish
      assert publish.day == "some updated day"
    end

    test "update_publish/2 with invalid data returns error changeset" do
      publish = publish_fixture()
      assert {:error, %Ecto.Changeset{}} = Comics.update_publish(publish, @invalid_attrs)
      assert publish == Comics.get_publish!(publish.id)
    end

    test "delete_publish/1 deletes the publish" do
      publish = publish_fixture()
      assert {:ok, %Publish{}} = Comics.delete_publish(publish)
      assert_raise Ecto.NoResultsError, fn -> Comics.get_publish!(publish.id) end
    end

    test "change_publish/1 returns a publish changeset" do
      publish = publish_fixture()
      assert %Ecto.Changeset{} = Comics.change_publish(publish)
    end
  end
end
