defmodule BecomicsWeb.ComicJSON do
  @doc """
  Renders a list of comics.
  """
  def index(%{comics: comics}) do
    %{data: for(comic <- comics, do: data(comic))}
  end

  @doc """
  Renders a single comic.
  """
  def show(%{comic: comic}) do
    %{data: data(comic)}
  end

  defp data(%Becomics.Comic{} = comic) do
    %{
      id: comic.id,
      name: comic.name,
      url: comic.url
    }
  end
end
