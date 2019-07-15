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

  test "given a user id that does not exist will return an error" do
    {:err, error} = LearnSymbols.get_symbol("nonExistent")
    assert error != nil
  end

  test "when answering increment correct guesses if right" do
    {:ok, symbol} = LearnSymbols.get_symbol(@user_id)
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

  test "ask for a symbol, answer it and ask for a symbol should return a different symbol" do
    {:ok, symbol1} = LearnSymbols.get_symbol(@user_id)
    {:ok, _answered} = LearnSymbols.answer(@user_id, symbol1.id, :yes)
    {:ok, symbol2} = LearnSymbols.get_symbol(@user_id)
    assert symbol1.id != symbol2.id
  end

  test "ask for a symbol, answer it wrong and its next date should be 30 seconds into the future" do
    {:ok, symbol} = LearnSymbols.get_symbol(@user_id)
    {:ok, answered} = LearnSymbols.answer(@user_id, symbol.id, :no)
    assert answered.next_show == DateTime.add(symbol.next_show, 30)
  end

  test "ask for a symbol, answer it wrong we should get a new symbol" do
    {:ok, symbol1} = LearnSymbols.get_symbol(@user_id)
    {:ok, _answered} = LearnSymbols.answer(@user_id, symbol1.id, :no)
    {:ok, symbol2} = LearnSymbols.get_symbol(@user_id)
    assert symbol1.id != symbol2.id
  end


  describe "when the user has one symbol" do
    setup [:user_with_one_symbol]
  end

  defp user_with_one_symbol(context) do
    {:ok, context}
  end
end
