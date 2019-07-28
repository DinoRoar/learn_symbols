defmodule LearnSymbols.UserProfile do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
    User profile is the external model for the web site to interact with.
    It holds the name and symbols that the user is learning
  """

  alias __MODULE__
  alias LearnSymbols.Symbol
  alias LearnSymbols.Repo

  require Logger
  require Poison

  schema "user_profiles" do
    field :provider_id, :string
    field :name, :string

    has_many :symbols, Symbol

    timestamps()
  end

  def new(provider_id, name, symbols) do
    case get(provider_id) do
      nil -> create_user_with_symbols(provider_id, name, symbols)
      user = %UserProfile{} -> {:ok, user}
    end
  end

  def get(provider_id) do
    result = UserProfile
             |> Repo.get_by(provider_id: provider_id)
             |> Repo.preload([:symbols])

    # Logger.debug "Getting user by provider id: #{Poison.encode!(result)}"
    result
  end

  defp create_user_with_symbols(provider_id, name, symbols) do
    with {:ok, user} <- Repo.insert(%UserProfile{provider_id: provider_id, name: name}) do
      symbols
      |> Enum.each(fn s -> add_symbol_to_user(user, s) end)

      {:ok, Repo.preload(user, [:symbols])}
    else
      err -> err
    end
  end

  def add_symbol_to_user(user = %UserProfile{}, symbol) do
    new_symbol = Symbol.new(symbol, user)
    symbol_with_assoc = Ecto.build_assoc(user, :symbols, new_symbol)
    Repo.insert(symbol_with_assoc)
  end

  def add_symbol_to_user(user_provider_id, symbol) do
    case get(user_provider_id) do
      nil -> {:err, :user_not_found}
      user = %UserProfile{} -> add_symbol_to_user(user, symbol)
    end
  end

  def remove_symbol_from_user(user = %UserProfile{}, symbol_id) do
    Logger.debug "removing symbol from: #{user.provider_id}, symbol: #{symbol_id}"
    with {:ok, symbol} <- Symbol.get_by_id(symbol_id) do
      case symbol.user_profile_id != user.id do
        true -> {:err, :symbol_does_not_belog_to_user}
        false -> Symbol.delete(symbol)
      end
    else
      err -> err
    end
  end

  def remove_symbol_from_user(user_provider_id, symbol_id) do
    case get(user_provider_id) do
      nil -> {:err, :user_not_found}
      user = %UserProfile{} -> remove_symbol_from_user(user, symbol_id)
      other -> other
    end
  end
end
