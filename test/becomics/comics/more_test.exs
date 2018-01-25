defmodule Becomics.MoreTest do
  use Becomics.DataCase

	describe "the manually created tests" do
		test "select_comics_published_on/1" do
			{:ok, comic} = Becomics.Comics.create_comic %{name: "kalle", url: "http://kalle.com"}
			day = "a day"
			{:ok, publish} = Becomics.Comics.create_publish %{comic_id: comic.id, day: day}
			cs = Becomics.Comics.select_comics_published_on publish.day
			assert (Enum.count cs) === 1
			c = Enum.at cs, 0
			assert c === comic
		end
	end
end
