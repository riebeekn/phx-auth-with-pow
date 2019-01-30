# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :warehouse,
  ecto_repos: [Warehouse.Repo]

# Configures the endpoint
config :warehouse, WarehouseWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Hi8Si1c8TLVt3oJuaxNPKeVR+TpnK8R4EOX0WOTtK1TNHild/ZFxy6Nq8ITVn/mS",
  render_errors: [view: WarehouseWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Warehouse.PubSub, adapter: Phoenix.PubSub.PG2]

# Pow configuration
config :warehouse, :pow,
  user: Warehouse.Users.User,
  repo: Warehouse.Repo,
  web_module: WarehouseWeb,
  extensions: [PowPersistentSession, PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: WarehouseWeb.Pow.Mailer,
  routes_backend: WarehouseWeb.Pow.Routes,
  messages_backend: WarehouseWeb.Pow.Messages

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
