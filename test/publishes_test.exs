defmodule Becomics.PublishesTest do
  use Becomics.DataCase

  describe "publishes" do
    import Becomics.PublishesFixtures

    @invalid_attrs %{day: nil}

    test "list_publishes/0 returns all publishes" do
      publish = publish_fixture()
      assert Becomics.list_publishes() == [publish]
    end

    test "get_publish!/1 returns the publish with given id" do
      publish = publish_fixture()
      assert Becomics.get_publish!(publish.id) == publish
    end

    test "create_publish/1 with valid data creates a publish" do
      valid_attrs = %{day: "some day"}

      assert {:ok, %Becomics.Publish{} = publish} = Becomics.create_publish(valid_attrs)
      assert publish.day == "some day"
    end

    test "create_publish/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Becomics.create_publish(@invalid_attrs)
    end

    test "update_publish/2 with valid data updates the publish" do
      publish = publish_fixture()
      update_attrs = %{day: "some updated day"}

      assert {:ok, %Becomics.Publish{} = publish} = Becomics.update_publish(publish, update_attrs)
      assert publish.day == "some updated day"
    end

    test "update_publish/2 with invalid data returns error changeset" do
      publish = publish_fixture()
      assert {:error, %Ecto.Changeset{}} = Becomics.update_publish(publish, @invalid_attrs)
      assert publish == Becomics.get_publish!(publish.id)
    end

    test "delete_publish/1 deletes the publish" do
      publish = publish_fixture()
      assert {:ok, %Becomics.Publish{}} = Becomics.delete_publish(publish)
      assert_raise Ecto.NoResultsError, fn -> Becomics.get_publish!(publish.id) end
    end

    test "change_publish/1 returns a publish changeset" do
      publish = publish_fixture()
      assert %Ecto.Changeset{} = Becomics.change_publish(publish)
    end
  end
end
