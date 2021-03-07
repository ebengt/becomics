defmodule Becomics.Repo do
  use Ecto.Repo,
    otp_app: :becomics,
    adapter: Ecto.Adapters.Postgres
end
