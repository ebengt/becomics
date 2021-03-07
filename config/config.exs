# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :becomics,
  ecto_repos: [Becomics.Repo]

# Example of day of week as number to day, in publishes table
config :becomics, daily_controller: %{1 => "Mon", 2 => "Tue", 3 => "Wed", 4 => "Thu", 5 => "Fri", 6 => "Sat", 7 => "Sun"}
# What to look for when sampling infrequent publishing, in publishes table
config :becomics, sample_controller: "infrequent"
# Overlap 1 so the user will see continuity (last item yesterday is todays first item)
config :becomics, sample_controller_overlap: 1

# Configures the endpoint
config :becomics, BecomicsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dMDoJbTZqFbc2xJzRld3IIgEaabpXOxV/KyoDWrwDlTdLBysnkBoKgTsVS8jQVCi",
  render_errors: [view: BecomicsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Becomics.PubSub,
  live_view: [signing_salt: "L226PMb/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
