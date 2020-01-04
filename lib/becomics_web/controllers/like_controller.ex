defmodule BecomicsWeb.LikeController do
  use BecomicsWeb, :controller
  # Must use import or p is undefined function
  import Ecto.Query, only: [from: 2]

  action_fallback BecomicsWeb.FallbackController

	def like conn, %{"like" => name} do
		s = name |> sane |> wildcard_join
		q = from p in Becomics.Comics.Comic, where: like(p.name, ^s)
		comics = Becomics.Repo.all(q)
		render conn, "like.html", comics: comics
	end


	defp sane( name ) do
		ss = Enum.filter( String.codepoints(name), &sane_string/1 )
		Enum.join(ss, "")
	end
	defp sane_string( s ) when s >= "a" and s <= "z", do: true
	defp sane_string( s ) when s >= "A" and s <= "Z", do: true
	defp sane_string( s ) when s >= "0" and s <= "9", do: true
	defp sane_string( "-" ), do: true
	defp sane_string( _ ), do: false

	defp wildcard_join( "" ), do: "nosuch"
	defp wildcard_join( name ), do: "%"<>name<>"%"
end
