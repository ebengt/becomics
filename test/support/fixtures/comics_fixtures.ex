defmodule Becomics.ComicsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Becomics.Comics` context.
  """

  @doc """
  Generate a comic.
  """
  def comic_fixture(attrs \\ %{}) do
    {:ok, comic} =
      attrs
      |> Enum.into(%{
        name: "some name",
        url: "http://some url"
      })
      |> Becomics.create_comic()

    comic
  end
end
