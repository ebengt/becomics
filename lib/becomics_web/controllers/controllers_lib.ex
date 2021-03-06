defmodule BecomicsWeb.ControllersLib do
  def comics(day) do
    day |> Becomics.Comics.select_comics_published_on() |> comics_sort
  end

  def comics_sort(comics) do
    Enum.sort(comics, &first_precedes_second?/2)
  end

  defp first_precedes_second?(first, second), do: first.name <= second.name
end
