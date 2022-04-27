defmodule BecomicsWeb.DailyController do
  use BecomicsWeb, :controller

  def daily(conn, _params) do
    comics = BecomicsWeb.ControllersLib.comics(day())
    sample = Application.get_env(:becomics, :sample_controller)
    overlap = Application.get_env(:becomics, :sample_controller_overlap)
    n = DateTime.utc_now()

    samples =
      sample
      |> BecomicsWeb.ControllersLib.comics()
      |> BecomicsWeb.SampleController.samples(n.day, overlap)

    render(conn, "daily.html", comics: comics, samples: samples)
  end

  # Exported for template
  def day_of_week_number do
    n = DateTime.utc_now()
    Calendar.ISO.day_of_week(n.year, n.month, n.day)
  end

  defp day do
    kv = Application.get_env(:becomics, :daily_controller)
    kv[day_of_week_number()]
  end
end
