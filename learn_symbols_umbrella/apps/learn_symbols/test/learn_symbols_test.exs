defmodule LearnSymbolsTest do
  use LearnSymbols.DataCase

  alias LearnSymbols

  @moduletag :capture_log

  doctest LearnSymbols

  test "module exists" do
    assert is_list(LearnSymbols.module_info())
  end

  test "create and get a user should be equivalent" do
    {:ok, profile} = LearnSymbols.create_user_if_new("123", "john")
    {:ok, another_profile} = LearnSymbols.get_user_profile("123")
    assert profile.name == another_profile.name
    assert Enum.count(another_profile.symbols) == 10
    assert profile.symbols == another_profile.symbols

  end

  test "returns user profile for existing user" do
    {:ok, profile} = LearnSymbols.create_user_if_new("123", "john")
    assert profile.name == "john"
    assert profile.id == "123"
  end

  test "by default symbols are 1 to 10" do
    {:ok, profile} = LearnSymbols.create_user_if_new("123", "john")
    assert Enum.map(profile.symbols, fn s -> s.symbol end) == ["1", "10", "2", "3", "4", "5", "6", "7", "8", "9"]
  end
end
