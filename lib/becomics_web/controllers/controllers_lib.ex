defmodule BecomicsWeb.ControllersLib do
  @moduledoc "Common functions for controllers"
  def comics(day) do
    day |> Becomics.select_comics_published_on() |> comics_sort
  end

  def comics_sort(comics) do
    Enum.sort(comics, &first_precedes_second?/2)
  end

  def prepare_to_render_form(maps),
    do:
      maps
      |> Enum.map(&Map.from_struct/1)
      |> Enum.map(&string_keys/1)

  def samples(comics, date, overlap) do
    days_in_month = DateTime.utc_now() |> DateTime.to_date() |> Date.days_in_month()
    zero_based = date - 1
    select(comics, days_in_month, zero_based, overlap)
  end

  #
  # Internal functions
  #

  defp first_precedes_second?(first, second), do: first.name <= second.name

  defp select([], _total_selection, _which, _overlap), do: []

  defp select(comics, total_selection, which, overlap) do
    samples_per_day = select_samples(comics, total_selection)
    select_loop(comics, samples_per_day, which, overlap)
  end

  defp select_loop(comics, [sample | _], 0, overlap), do: Enum.take(comics, sample + overlap)

  defp select_loop(comics, [sample | t], count_down, overlap),
    do: select_loop(Enum.drop(comics, sample), t, count_down - 1, overlap)

  defp select_samples(comics, total_selection) do
    amount = Enum.count(comics)
    low_per_day = Kernel.div(amount, total_selection)
    high_per_day = low_per_day + 1
    low_selection = low_per_day * total_selection
    days_with_high_selection = amount - low_selection

    List.duplicate(high_per_day, days_with_high_selection) ++
      List.duplicate(low_per_day, total_selection - days_with_high_selection)
  end

  defp string_keys(map), do: Enum.reduce(map, %{}, &string_key_value/2)

  # Existing URL in href.
  # Avoid URL in form.
  defp string_key_value({:url, value}, acc),
    do: acc |> Map.put("url", "") |> Map.put("url_for_href", value)

  defp string_key_value({key, value}, acc), do: Map.put(acc, Atom.to_string(key), value)

  if Mix.env() === :test do
    def test_select(comics, total_selection, which), do: select(comics, total_selection, which, 0)

    def test_select(comics, total_selection, which, overlap),
      do: select(comics, total_selection, which, overlap)

    def test_select_samples(comics, total_selection), do: select_samples(comics, total_selection)
  end
end
