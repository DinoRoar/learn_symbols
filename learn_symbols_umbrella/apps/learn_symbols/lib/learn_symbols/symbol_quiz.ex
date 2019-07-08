defmodule LearnSymbols.SymbolQuiz do
  @moduledoc """
    Looks after choosing symbols and what to do with right or wrong answers
  """

  require Logger
  require Poison

  alias LearnSymbols.Symbol
  alias LearnSymbols.Repo

  def get_symbol(symbols, current_datetime) do
    if are_all_symbols(symbols) do
      {:ok, choose_symbol(symbols, current_datetime)}
    else
      {:err, :not_all_symbols_are_symbols}
    end
  end

  def answer(user_id, symbol_id, :yes) do
    persisted_symbol = Symbol
                       |> Repo.get!(symbol_id)
                       |> Repo.preload(:user_profile)

    if (persisted_symbol.user_profile.provider_id == user_id) do
      persisted_symbol
      |> increment_correct_answers
      |> set_next_show(DateTime.add(persisted_symbol.next_show, 60 * 60))
      |> Repo.update()
    else
      {:err, :symbol_does_not_belong_to_given_user}
    end
  end

  defp increment_correct_answers(symbol = %Symbol{}) do
    Ecto.Changeset.change(symbol, %{correct_answers: symbol.correct_answers + 1})
  end

  defp set_next_show(symbol_changeset, next_show) do
    Ecto.Changeset.put_change(symbol_changeset, :next_show, next_show )
  end


  defp are_all_symbols(symbols) do
    Enum.all?(
      symbols,
      fn
        %Symbol{} -> true
        _ -> false
      end
    )
  end


  defp choose_symbol(symbols, current_datetime) do
    symbol = symbols
             |> Enum.map(fn s -> %{score: score_symbol(s, current_datetime), symbol: s} end)
             |> Enum.sort(&(&1.score >= &2.score))


    hd(symbol).symbol
  end

  defp score_symbol(symbol, current_datetime) do
    diff = DateTime.diff(symbol.next_show, current_datetime)
    diff
  end
end
