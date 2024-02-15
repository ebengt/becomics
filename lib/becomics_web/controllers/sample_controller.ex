defmodule BecomicsWeb.SampleController do
  use Phoenix.Controller,
    formats: [:html]

  def like(conn, %{"like" => name}) do
    comics =
      name
      |> sane_name()
      |> wildcard_join()
      |> Becomics.comic_like()
      |> BecomicsWeb.ControllersLib.prepare_to_render_form()

    render(conn, :sample, comics: comics)
  end

  def sample(conn, %{"date" => date}) do
    sample = Application.get_env(:becomics, :sample_controller)
    overlap = Application.get_env(:becomics, :sample_controller_overlap)

    samples =
      sample
      |> BecomicsWeb.ControllersLib.comics()
      |> BecomicsWeb.ControllersLib.samples(String.to_integer(date), overlap)
      |> BecomicsWeb.ControllersLib.prepare_to_render_form()

    render(conn, :sample, comics: samples)
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
