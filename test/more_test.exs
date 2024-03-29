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

    test "like/2" do
      {:ok, comic} =
        Becomics.create_comic(%{name: "asd kalle 123", url: "http://like.com"})

      q = from p in Becomics.Comic, where: like(p.name, "%kalle%")
      [c] = Repo.all(q)
      assert c === comic
    end
  end
end
