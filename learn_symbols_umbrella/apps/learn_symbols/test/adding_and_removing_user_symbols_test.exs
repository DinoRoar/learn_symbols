defmodule AddingAndRemovingUserSymbolsTest do
  use LearnSymbols.DataCase

  alias LearnSymbols.UserProfile
  alias LearnSymbols.Symbol

  alias LearnSymbols.Repo

  require Logger

  @user_id "123"
  @user_name "john"

  @moduletag :capture_log

  test "can add a symbol to a user" do
    {:ok, profile} = LearnSymbols.create_user_if_new(@user_id, @user_name, [])
    assert profile.symbols == []

    {:ok, symbol} = LearnSymbols.add_symbol_to_user(@user_id, "dave")
    assert symbol.symbol == "dave"

    user = UserProfile.get @user_id
    assert Enum.count(user.symbols) == 1
  end

  test "can remove an added symbol from a user" do
    {:ok, profile} = LearnSymbols.create_user_if_new(@user_id, @user_name, [])
    {:ok, symbol} = LearnSymbols.add_symbol_to_user(@user_id, "dave")

    Logger.debug "Symbol Id being removed is: #{symbol.id}"

    :ok = LearnSymbols.remove_symbol_from_user(@user_id, symbol.id)

    non_existing_symbol = Symbol.get_by_id(symbol.id)


#    non_existing_symbol = Symbol.get_by_id(symbol.id)
    assert non_existing_symbol == {:err, :symbol_does_not_exist}
  end


end
