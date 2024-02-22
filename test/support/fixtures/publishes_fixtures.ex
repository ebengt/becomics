defmodule Becomics.PublishesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Becomics.Publishes` context.
  """

  @doc """
  Generate a publish.
  """
  def publish_fixture(attrs \\ %{}) do
    {:ok, publish} =
      attrs
      |> Enum.into(%{
        day: "some day"
      })
      |> Becomics.create_publish()

    publish
  end
end
