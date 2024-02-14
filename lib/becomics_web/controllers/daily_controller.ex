defmodule BecomicsWeb.DailyController do
  use Phoenix.Controller,
    formats: [:html]

  def daily(conn, _params) do
    comics = day() |> BecomicsWeb.ControllersLib.comics()
    sample = Application.get_env(:becomics, :sample_controller)
    overlap = Application.get_env(:becomics, :sample_controller_overlap)
    n = Date.utc_today()

    samples =
      sample
      |> BecomicsWeb.ControllersLib.comics()
      |> BecomicsWeb.ControllersLib.samples(n.day, overlap)
      |> BecomicsWeb.ControllersLib.prepare_to_render_form()

    render(conn, :daily, comics: comics, samples: samples)
  end

  # Exported for template
  def day_of_week_number do
    n = Date.utc_today()
    {n, 1, 7} = Calendar.ISO.day_of_week(n.year, n.month, n.day, :monday)
    n
  end

  defp day do
    kv = Application.get_env(:becomics, :daily_controller)
    kv[day_of_week_number()]
  end
end
