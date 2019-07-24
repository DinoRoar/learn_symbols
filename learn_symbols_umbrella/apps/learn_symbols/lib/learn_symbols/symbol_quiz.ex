defmodule LearnSymbols.SymbolQuiz do
  @moduledoc """
    Looks after choosing symbols and what to do with right or wrong answers, has get_symbol/2 and answer/3 functions
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
             |> Enum.sort(&(&1.score <= &2.score))

    hd(symbol).symbol
  end

  defp score_symbol(symbol, current_datetime) do
    DateTime.diff(symbol.next_show, current_datetime, :second)
  end



  def answer(user_id, symbol_id, :yes) do
    get_and_check_symbol(user_id, symbol_id, &answer_question_yes/1)
  end

  def answer(user_id, symbol_id, :no) do
    get_and_check_symbol(user_id, symbol_id, &answer_question_no/1)
  end

  defp answer_question_yes(symbol) do
    symbol
    |> Ecto.Changeset.change(
         %{
           correct_answers: symbol.correct_answers + 1,
           next_show: DateTime.add(symbol.next_show, 60 * 60)
         }
       )
    |> Repo.update()
  end

  defp answer_question_no(symbol) do
    symbol
    |> Ecto.Changeset.change(
         %{
           correct_answers: 0,
           next_show: DateTime.add(symbol.next_show, 30)
         }
       )
    |> Repo.update()
  end

  defp get_and_check_symbol(user_id, symbol_id, action_to_apply) do
    with {:ok, persisted_symbol} <- Symbol.get_with_profile(symbol_id),
         {:ok, _} <- check_symbol_belongs_to_user(persisted_symbol, user_id) do
      action_to_apply.(persisted_symbol)
      else
      err->err
    end
  end

  defp check_symbol_belongs_to_user(symbol, user_id) do
    if (symbol.user_profile.provider_id == user_id) do
      {:ok, symbol}
    else
      {:err, :symbol_does_not_belong_to_given_user}
    end
  end
end
