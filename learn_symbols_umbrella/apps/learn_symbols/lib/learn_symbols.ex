defmodule LearnSymbols do
  @moduledoc """
  LearnSymbols keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """


  def init_profile(name, code) do
    {:ok, UserProfile.new(name, code)}
  end
end
