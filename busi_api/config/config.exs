# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :busi_api,
  ecto_repos: [BusiApi.Repo]

# Configures the endpoint
config :busi_api, BusiApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TQ5Wbm/XjnKAoTSOw/PMPCV27pvp35xnV+U7lHBgeyBow8mKtnMy1uRZ+nftHFF7",
  render_errors: [view: BusiApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BusiApi.PubSub,
  live_view: [signing_salt: "btVDkqJ6"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :busi_api, BusiApiWeb.Auth.Guardian,
  ttl: {1, :minute},
  issuer: "busi_api",
  secret_key: "RDwZ9tINKUdQ+EeKDoG6PVLNZjU0l6mZGaKYOUo7kwCqLF8AjAMbEJcuzzQagPZX"
