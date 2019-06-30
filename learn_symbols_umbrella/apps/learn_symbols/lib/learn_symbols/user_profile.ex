defmodule LearnSymbols.UserProfile do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
    User profile is the external model for the web site to interact with.
    It holds the name and symbols that the user is learning
  """

  alias __MODULE__
  alias LearnSymbols.Symbol
  alias LearnSymbols.Repo

  require Logger
  require Poison

  schema "user_profiles" do
    field :provider_id, :string
    field :name, :string

    has_many :symbols, Symbol

    timestamps()
  end

  @default_symbols ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

  def new(provider_id, name) do
    Logger.debug "creatign new"
    case get(provider_id) do
      nil -> create_user_with_symbols(provider_id, name, @default_symbols)
      user = %UserProfile{} -> {:ok, user}
    end
  end

  def get(provider_id) do
    UserProfile
    |> Repo.get_by(provider_id: provider_id)
    |> Repo.preload([:symbols])
  end

  defp create_user_with_symbols(provider_id, name, symbols) do
    with {:ok, user} <- Repo.insert(%UserProfile{provider_id: provider_id, name: name}) do
      symbols
      |> Enum.map(fn s -> Symbol.new(s, user) end)
      |> Enum.each(
           fn s ->
             symbol = Ecto.build_assoc(user, :symbols, s)
             Repo.insert(symbol)
           end
         )

      {:ok, Repo.preload(user, [:symbols])}
    else
      err -> err
    end
  end
end
