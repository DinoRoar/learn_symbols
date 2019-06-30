use Mix.Config

# Configure your database
config :learn_symbols, LearnSymbols.Repo,
  username: "postgres",
  password: "postgres",
  database: "learn_symbols_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :learn_symbols_web, LearnSymbolsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
#config :logger, level: :warn

config :logger,
       backends: [:console],
       compile_time_purge_level: :debug