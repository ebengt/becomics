defmodule BecomicsWeb.LikeController do
  use Phoenix.Controller,
    formats: [:html]

  def like(conn, %{"like" => name}) do
    s = name |> sane_name |> wildcard_join
    comics = Becomics.comic_like(s) |> BecomicsWeb.ControllersLib.prepare_to_render_form()

    render(conn, :like, comics: comics)
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
  defp wildcard_join(name, length) when length < 3, do: "%" <> name
  defp wildcard_join(name, _length), do: "%" <> name <> "%"
end
