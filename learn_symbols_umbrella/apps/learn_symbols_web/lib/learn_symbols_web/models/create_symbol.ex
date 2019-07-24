defmodule LearnSymbolsWeb.CreateSymbol do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
    Model representing a symbol to be created
  """

  schema "symbols" do
    field :symbol
  end

  def changeset(symbol, params \\ %{}) do
    symbol
    |> cast(params, [:symbol])
    |> validate_required([:symbol])
  end
end
