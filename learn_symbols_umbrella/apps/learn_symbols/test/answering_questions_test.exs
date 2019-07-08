defmodule AnsweringQuestionsTest do
  use LearnSymbols.DataCase

  alias LearnSymbols

  require Logger
  require Poison

  @moduletag :capture_log

  @user_id "123"
  @user_name "john"

  setup do
    {:ok, profile} = LearnSymbols.create_user_if_new(@user_id, @user_name)
    {:ok, profile: profile}
  end

  test "given a user id will return a symbol" do
    {:ok, symbol} = LearnSymbols.get_symbol(@user_id)
    assert symbol.symbol == "1"
  end

  test "when answering increment correct guesses if right" do
    {:ok, symbol} = LearnSymbols.get_symbol(@user_id)
    Logger.info Poison.encode!(symbol)
    assert symbol.correct_answers == 0
    last_time = symbol.next_show
    {:ok, answered} = LearnSymbols.answer(@user_id, symbol.id, :yes)
    assert answered.correct_answers == 1
    assert answered.next_show == DateTime.add(last_time, 60 * 60)
  end

  test "ask for a symbol twice, get the same symbol" do
    symbol1 = LearnSymbols.get_symbol(@user_id)
    symbol2 = LearnSymbols.get_symbol(@user_id)

    assert symbol1 == symbol2
  end
end
