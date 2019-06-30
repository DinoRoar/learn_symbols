defmodule LearnSymbolsTest do
  use LearnSymbols.DataCase

  alias LearnSymbols

  @moduletag :capture_log

  doctest LearnSymbols

  test "module exists" do
    assert is_list(LearnSymbols.module_info())
  end

  test "returns user profile for existing user" do
    {:ok, profile} = LearnSymbols.create_user_if_new("123", "john")
    assert profile.name == "john"
    assert profile.provider_id == "123"
  end

  test "by default symbols are 1 to 10" do
    {:ok, profile} = LearnSymbols.create_user_if_new("123", "john")
    assert Enum.map(profile.symbols, fn s -> s.symbol end) == ["1", "10", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  test "given a user id will return a symbol" do
    {:ok, profile} = LearnSymbols.create_user_if_new("123", "john")
    {:ok, symbol} = LearnSymbols.get_next_symbol("123")

    assert symbol == "1"
  end


  test "when answering increment correct guesses if right" do
    {:ok, profile} = LearnSymbols.create_user_if_new("123", "john")
    {:ok, symbol} = LearnSymbols.get_next_symbol("123")
    assert LearnSymbols.answer("123", "1", :yes) == :ok

  end
end
