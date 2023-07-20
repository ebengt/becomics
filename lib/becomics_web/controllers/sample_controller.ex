defmodule BecomicsWeb.SampleController do
  use BecomicsWeb, :controller

  def sample(conn, %{"date" => date}) do
    sample = Application.get_env(:becomics, :sample_controller)
    overlap = Application.get_env(:becomics, :sample_controller_overlap)

    samples =
      sample |> BecomicsWeb.ControllersLib.comics() |> samples(String.to_integer(date), overlap)

    render(conn, "sample.html", samples: samples)
  end

  def samples(comics, date, overlap) do
    days_in_month = DateTime.utc_now() |> DateTime.to_date() |> Date.days_in_month()
    zero_based = date - 1
    select(comics, days_in_month, zero_based, overlap)
  end

  #
  # Internal functions
  #

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

  if Mix.env() === :test do
    def test_select(comics, total_selection, which), do: select(comics, total_selection, which, 0)

    def test_select(comics, total_selection, which, overlap),
      do: select(comics, total_selection, which, overlap)

    def test_select_samples(comics, total_selection), do: select_samples(comics, total_selection)
  end
end
