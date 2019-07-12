# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :learn_symbols,
       ecto_repos: [LearnSymbols.Repo]

config :learn_symbols_web,
       ecto_repos: [LearnSymbols.Repo],
       generators: [
         context_app: :learn_symbols
       ]

# Configures the endpoint
config :learn_symbols_web,
       LearnSymbolsWeb.Endpoint,
       url: [
         host: "localhost"
       ],
       secret_key_base: "4R9fagvGhmck5P2gOeYCFDBRIzGf+WJTZBnC29G44eHF9/hjH4tCp1Xc+SyAKDht",
       render_errors: [
         view: LearnSymbolsWeb.ErrorView,
         accepts: ~w(html json)
       ],
       pubsub: [
         name: LearnSymbolsWeb.PubSub,
         adapter: Phoenix.PubSub.PG2
       ],
       live_view: [
         signing_salt: "bRraLWt1sz8g1FKUgpiZhQQCxfnleQ4p3Z5NwCmSpIzmnJgAtlKRpiOd7uhRMhAe"
       ]


# Configures Elixir's Logger
config :logger,
       :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# setup leex templates to work
config :phoenix,
       template_engines: [leex: Phoenix.LiveView.Engine]

# Configures Ueberauth
config :ueberauth,
       Ueberauth,
       providers: [
         auth0: {Ueberauth.Strategy.Auth0, []},
       ]

# Configures Ueberauth's Auth0 auth provider
config :ueberauth,
       Ueberauth.Strategy.Auth0.OAuth,
       domain: System.get_env("AUTH0_DOMAIN"),
       client_id: System.get_env("AUTH0_CLIENT_ID"),
       client_secret: System.get_env("AUTH0_CLIENT_SECRET")



# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
