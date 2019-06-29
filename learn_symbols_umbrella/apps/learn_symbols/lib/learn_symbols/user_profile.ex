defmodule LearnSymbols.UserProfile do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
    User profile is the external model for the web site to interact with.
    It holds the name and symbols that the user is learning
  """

  alias __MODULE__
  alias LearnSymbols.Symbol

  schema "user_profiles" do
    field :provider_id, :string
    field :name, :string

    has_many :symbols, Symbol

    timestamps()
  end


  @default_symbols ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

  def new(provider_id, name) do
    %UserProfile{provider_id: provider_id, name: name, symbols: Enum.map(@default_symbols, fn s -> Symbol.new(s) end)}
  end
end
