defmodule BecomicsWeb.PublishJSON do
  @doc """
  Renders a list of publishes.
  """
  def index(%{publishes: publishes}) do
    %{data: for(publish <- publishes, do: data(publish))}
  end

  @doc """
  Renders a single publish.
  """
  def show(%{publish: publish}) do
    %{data: data(publish)}
  end

  defp data(%Becomics.Publish{} = publish) do
    %{
      id: publish.id,
      day: publish.day,
      comic_id: publish.comic_id
    }
  end
end
