defmodule UserProfileTest do
  use ExUnit.Case

  alias LearnSymbols.UserProfile

  @moduletag :capture_log

  doctest LearnSymbols.UserProfile

  test "module exists" do
    assert is_list(UserProfile.module_info())
  end

end
