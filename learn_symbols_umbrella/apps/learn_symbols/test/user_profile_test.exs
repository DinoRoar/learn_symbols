defmodule UserProfileTest do
  use ExUnit.Case

  alias UserProfile

  @moduletag :capture_log

  doctest UserProfile

  test "module exists" do
    assert is_list(UserProfile.module_info())
  end

end
