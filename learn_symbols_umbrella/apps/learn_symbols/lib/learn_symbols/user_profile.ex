defmodule UserProfile do
  @moduledoc """
  User profile is the external model for the web site to interact with.
  It holds the name and symbols that the user is learning
"""

  alias __MODULE__

  @default_symbols ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

  @enforce_keys [:name, :code, :symbols]
  defstruct [:name, :code, :symbols]

  def new(name, code) do
    %UserProfile{name: name, code: code, symbols: @default_symbols}
  end
end
