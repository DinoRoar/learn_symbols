defmodule LearnSymbolsTest do
  use ExUnit.Case

  alias LearnSymbols

  @moduletag :capture_log

  doctest LearnSymbols

  test "module exists" do
    assert is_list(LearnSymbols.module_info())
  end

  test "returns user profile for existing user" do
    {:ok, profile} = LearnSymbols.init_profile("123", "john")
    assert profile.name == "john"
    assert profile.id == "123"
  end

  test "by default symbols are 1 to 10" do
    {:ok, profile} = LearnSymbols.init_profile("123", "john")
    assert profile.symbols == ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

  end

end
