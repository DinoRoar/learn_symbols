defmodule LearnSymbols.Symbol do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias LearnSymbols.UserProfile
  alias LearnSymbols.Repo

  require Logger

  @moduledoc """
    A symbol a user is trying to learn,
  the next time it should be shown
  and the number of correct guesses
  """

  schema "symbols" do
    field :symbol, :string
    field :next_show, :utc_datetime
    field :correct_answers, :integer

    belongs_to :user_profile, UserProfile

    timestamps()
  end

  @doc """
  Returns a new Symbol
  """
  def new(symbol, user_profile) do
    %Symbol{
      symbol: symbol,
      next_show: DateTime.truncate(DateTime.utc_now, :second),
      correct_answers: 0,
      user_profile: user_profile
    }
  end

  @doc """
  gets a symbol preloaded with user profile
  """
  def get_with_profile(symbol_id) do
     with {:ok, symbol} <- get_by_id(symbol_id) do
       {:ok, symbol |> Repo.preload(:user_profile)}
       else
       err -> err
     end

  end

  def get_by_id(symbol_id) do
    case Symbol
         |> Repo.get(symbol_id) do
      nil -> {:err, :symbol_does_not_exist}
      symbol -> {:ok, symbol}
    end

  end

  def delete(symbol) do
    Logger.debug "deleting symbol #{symbol.id}"
    Repo.delete symbol
    Logger.debug "deleted symbol #{symbol.id}"
  end
end
