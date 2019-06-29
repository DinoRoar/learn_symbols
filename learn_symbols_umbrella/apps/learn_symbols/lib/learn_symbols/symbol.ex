defmodule LearnSymbols.Symbol do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias LearnSymbols.UserProfile


  @moduledoc """
  A symbol a user is trying to learn,
the next time it should be shown
and the number of correct guesses
"""

  schema "symbols" do
    field :symbol, :string
    field :next_show, :date
    field :correct_answers, :integer

    belongs_to :user_profile, UserProfile

    timestamps()
  end

  def new(symbol) do
    %Symbol{symbol: symbol, next_show: DateTime.utc_now, correct_answers: 0}
  end


end