defmodule Becomics.MoreTest do
  use Becomics.DataCase

  describe "the manually created tests" do
    test "select_comics_published_on/1" do
      {:ok, comic} = Becomics.create_comic(%{name: "kalle", url: "http://kalle.com"})
      day = "a day"
      {:ok, publish} = Becomics.create_publish(%{comic_id: comic.id, day: day})

      cs = Becomics.select_comics_published_on(publish.day)

      assert Enum.count(cs) === 1
      c = Enum.at(cs, 0)
      assert c === comic
    end

    test "comic_like/1" do
      {:ok, comic} =
        Becomics.create_comic(%{name: "asd kalle 123", url: "http://like.com"})

      cs = Becomics.comic_like("%kalle%")

      assert Enum.count(cs) === 1
      c = Enum.at(cs, 0)
      assert c === comic
    end

    test "publishes_days/0" do
      {:ok, comic} = Becomics.create_comic(%{name: "kalle", url: "http://kalle.com"})
      day = "a day"
      {:ok, _publish1} = Becomics.create_publish(%{comic_id: comic.id, day: day})
      another = "another"
      {:ok, _publish2} = Becomics.create_publish(%{comic_id: comic.id, day: another})

      cs = Becomics.publishes_days()

      assert Enum.count(cs) === 2
      assert Enum.member?(cs, day)
      assert Enum.member?(cs, another)
    end

    test "publishes_for_comic/1" do
      {:ok, comic} = Becomics.create_comic(%{name: "kalle", url: "http://kalle.com"})
      day = "a day"
      {:ok, _publish1} = Becomics.create_publish(%{comic_id: comic.id, day: day})

      ps = Becomics.publish_from_comic(comic.id)

      assert Enum.count(ps) === 1
      p = Enum.at(ps, 0)
      assert p.day === day
    end
  end
end
