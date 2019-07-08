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

  def get_user_profile(id) do
    case UserProfile.get(id) do
      nil -> {:err, :user_not_found}
      user -> {:ok, user}
    end
  end

  def create_user_if_new(id, name) do
    UserProfile.new(id, name)
  end

  def get_symbol(user_id) do
    user = UserProfile.get(user_id)
    SymbolQuiz.get_symbol(user.symbols, DateTime.utc_now)
  end

  def answer(user_id, symbol_id, answer) do
    SymbolQuiz.answer(user_id, symbol_id, answer)
  end
end
