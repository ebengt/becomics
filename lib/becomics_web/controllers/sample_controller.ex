defmodule BecomicsWeb.SampleController do
	use BecomicsWeb, :controller

	def sample conn, %{"date" => date} do
		sample = Application.get_env :becomics, :sample_controller
		samples = sample |> BecomicsWeb.ControllersLib.comics |> (samples (String.to_integer date))
		render conn, "sample.html", samples: samples
	end

	def samples comics, date do
		days_in_month = DateTime.utc_now |> DateTime.to_date |> Date.days_in_month
		zero_based = date - 1
		select comics, days_in_month, zero_based
	end
	@doc """
	select a subset given how many such subsets there should be (days) and which of the subsets
	it is.
	Overlap 1 so the user will see continuity (last item yesterday is todays first item).
	"""
	def select comics, days, which do
		sample_size = (Enum.count comics) / days
		Enum.slice comics, (int sample_size * which), (int (sample_size + 1))
	end



	defp (int f), do: Kernel.trunc (Float.round f)
end
