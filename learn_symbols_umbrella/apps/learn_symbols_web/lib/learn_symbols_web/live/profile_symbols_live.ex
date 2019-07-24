defmodule LearnSymbolsWeb.ProfileSymbolsLiveView do
  use Phoenix.LiveView

  alias LearnSymbols

  require Logger
  require Poison

  @moduledoc false


  def render(assigns) do
    Phoenix.View.render(LearnSymbolsWeb.PageView, "profile_symbols_live.html", assigns)
  end

  def mount(%{user_id: user_id}, socket) do
    {:ok, user} = LearnSymbols.get_user_profile(user_id)
    {:ok, assign(socket, user_id: user_id, symbols: user.symbols)}
  end

  def handle_event(
        "delete-symbol",
        symbol_id,
        %{
          assigns: %{
            user_id: user_id
          }
        } = socket
      ) do
    Logger.debug symbol_id
    :ok = LearnSymbols.remove_symbol_from_user(user_id, symbol_id)
    {:ok, user} = LearnSymbols.get_user_profile(user_id)
    {:noreply, assign(socket, symbols: user.symbols)}
  end

  def handle_event("validate", %{"create_symbol" => symbol}, %{assigns: assigns} = socket) do
    # Logger.debug assigns
    {:noreply, assign(socket, assigns)}
  end

  def handle_event(
        "create",
        %{"create_symbol" => symbol},
        %{
          assigns: %{
            user_id: user_id
          }
        } = socket
      ) do
    LearnSymbols.add_symbol_to_user(user_id, symbol["symbol"])
    {:ok, user} = LearnSymbols.get_user_profile(user_id)
    {:noreply, assign(socket, symbols: user.symbols)}
  end


end

