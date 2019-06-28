defmodule LearnSymbols do

  alias LearnSymbols.UserProfile

  @moduledoc """
  LearnSymbols keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """


  def init_profile(id, name) do
    {:ok, UserProfile.new(id, name)}
  end
end
