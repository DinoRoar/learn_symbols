defmodule LearnSymbols do

  alias LearnSymbols.UserProfile
  alias LearnSymbols.SymbolQuiz
  alias LearnSymbols.Symbol

  @moduledoc """
  LearnSymbols keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  @default_symbols ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

  def get_user_profile(user_provider_id) do
    case UserProfile.get(user_provider_id) do
      nil ->
        {:err, :user_not_found}
      user ->
        {
          :ok,
          user
          |> user_to_map
        }
    end
  end

  defp user_to_map(user) do
    %{
      id: user.provider_id,
      name: user.name,
      symbols: user.symbols
               |> Enum.map(fn s -> symbol_to_map(s) end)
    }
  end

  defp symbol_to_map(symbol) do
    %{id: symbol.id, symbol: symbol.symbol, next_show: symbol.next_show, correct_answers: symbol.correct_answers}
  end

  def create_user_if_new(user_provider_id, name, symbols \\ @default_symbols) do
    with {:ok, user} <- UserProfile.new(user_provider_id, name, symbols) do
      {:ok, user_to_map(user)}
    else
      err -> err
    end
  end

  def get_symbol(user_provider_id) do
    user = UserProfile.get(user_provider_id)
    SymbolQuiz.get_symbol(user.symbols, DateTime.utc_now)
  end

  def answer(user_provider_id, symbol_id, answer) do
    SymbolQuiz.answer(user_provider_id, symbol_id, answer)
  end
end
