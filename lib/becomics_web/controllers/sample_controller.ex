defmodule BecomicsWeb.SampleController do
  use Phoenix.Controller,
    formats: [:html]

  def days(conn, _) do
    days = Becomics.publishes_days()
    render(conn, :days, days: days)
  end

  def day(conn, %{"day" => day}) do
    comics =
      BecomicsWeb.ControllersLib.comics(day)
      |> publish_id(day)
      |> BecomicsWeb.ControllersLib.prepare_to_render_form()

    days = Becomics.publishes_days()
    render(conn, :day, comics: comics, day: day, days: days)
  end

  def like(conn, %{"like" => name}) do
    comics =
      name
      |> sane_name()
      |> wildcard_join()
      |> Becomics.comic_like()
      |> BecomicsWeb.ControllersLib.prepare_to_render_form()

    render(conn, :sample, comics: comics)
  end

  defp publish_id(comics, day) do
    f = fn comic -> Becomics.publish_from_comic(comic.id) |> publish_id(comic, day) end
    Enum.map(comics, f)
  end

  defp publish_id(publishes, comic, day) do
    f = fn publish -> publish.day === day end
    [publish] = Enum.filter(publishes, f)
    Map.put(comic, :publish_id, publish.id)
  end

  defp sane_name(name) do
    name |> String.codepoints() |> Enum.filter(&sane_string/1) |> Enum.join("")
  end

  defp sane_string(s) when s >= "a" and s <= "z", do: true
  defp sane_string(s) when s >= "A" and s <= "Z", do: true
  defp sane_string(s) when s >= "0" and s <= "9", do: true
  defp sane_string("-"), do: true
  defp sane_string(" "), do: true
  defp sane_string(_), do: false

  defp wildcard_join(name), do: wildcard_join(name, String.length(name))
  defp wildcard_join("", 0), do: "nosuch"
  defp wildcard_join(name, length) when length < 3, do: name <> "%"
  defp wildcard_join(name, _length), do: "%" <> name <> "%"
end
