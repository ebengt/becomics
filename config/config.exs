# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Example of day of week as number to day, in publishes table
config :becomics, daily_controller: %{1 => "Mon", 2 => "Tue", 3 => "Wed", 4 => "Thu", 5 => "Fri", 6 => "Sat", 7 => "Sun"}
config :becomics, sample_controller: "infrequent"

# General application configuration
config :becomics,
  ecto_repos: [Becomics.Repo]

# Configures the endpoint
config :becomics, BecomicsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QwuzNrPGANWupKd0rkxjVzIat90eGHZUm12gWVuQ+m9nFd6nS9PGrjVu1gvYY4yE",
  render_errors: [view: BecomicsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Becomics.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
