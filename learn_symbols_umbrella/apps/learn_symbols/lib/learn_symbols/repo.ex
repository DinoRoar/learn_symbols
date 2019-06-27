defmodule LearnSymbols.Repo do
  use Ecto.Repo,
    otp_app: :learn_symbols,
    adapter: Ecto.Adapters.Postgres
end
