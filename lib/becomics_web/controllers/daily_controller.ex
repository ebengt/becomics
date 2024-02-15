defmodule BecomicsWeb.DailyController do
  use Phoenix.Controller,
    formats: [:html]

  def daily(conn, _params) do
    comics_render(conn, Date.utc_today())
  end

  def date(conn, %{"date" => date}) do
    today = Date.utc_today()
    day_number = String.to_integer(date)
    comics_render(conn, Date.new!(today.year, today.month, day_number))
  end

  defp comics_render(conn, date) do
    day = date |> day_of_week_number()
    comics = day |> day_in_database() |> BecomicsWeb.ControllersLib.comics()

    sample = Application.get_env(:becomics, :sample_controller)
    overlap = Application.get_env(:becomics, :sample_controller_overlap)

    samples =
      sample
      |> BecomicsWeb.ControllersLib.comics()
      |> BecomicsWeb.ControllersLib.samples(date.day, overlap)
      |> BecomicsWeb.ControllersLib.prepare_to_render_form()

    render(conn, :daily, comics: comics, samples: samples, day_of_week_number: day)
  end

  def day_of_week_number(date) do
    {n, 1, 7} = Calendar.ISO.day_of_week(date.year, date.month, date.day, :monday)
    n
  end

  defp day_in_database(day_of_week_number) do
    kv = Application.get_env(:becomics, :daily_controller)
    kv[day_of_week_number]
  end
end
