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
      |> prepare_to_render()

    render(conn, :daily, comics: comics, samples: samples)
  end

  # Exported for template
  def day_of_week_number do
    n = Date.utc_today()
    {n, 1, 7} = Calendar.ISO.day_of_week(n.year, n.month, n.day, :monday)
    n
  end

  def post_from_form(conn, %{"id" => id, "url" => url}) do
    comic = Becomics.get_comic!(id)

    with {:ok, %Becomics.Comic{} = comic} <-
           Becomics.update_comic(comic, %{url: url}) do
      render(conn, :show, comic: comic)
    end
  end

  defp day do
    kv = Application.get_env(:becomics, :daily_controller)
    kv[day_of_week_number()]
  end

  defp prepare_to_render(maps),
    do:
      maps
      |> Enum.map(&Map.from_struct/1)
      |> Enum.map(&string_keys/1)

  defp string_keys(map), do: Enum.reduce(map, %{}, &string_key_value/2)

  # Existing URL in href.
  # Avoid URL in form.
  defp string_key_value({:url, value}, acc),
    do: acc |> Map.put("url", "") |> Map.put("url_for_href", value)

  defp string_key_value({key, value}, acc), do: Map.put(acc, Atom.to_string(key), value)
end
