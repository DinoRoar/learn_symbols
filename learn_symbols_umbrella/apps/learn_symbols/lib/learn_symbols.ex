defmodule LearnSymbols do

  alias LearnSymbols.UserProfile

  @moduledoc """
  LearnSymbols keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """


  def create_user_if_new(id, name) do
    {:ok, UserProfile.new(id, name)}
  end

  def get_next_symbol(user_id) do
    {:ok, "1"}
  end

  def answer(user, symbol, result) do
    :ok
  end
end
