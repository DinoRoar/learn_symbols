defmodule LearnSymbolsWeb.ProfileSymbolsLiveView do
  use Phoenix.LiveView

  alias LearnSymbols

  require Logger
  require Poison

  @moduledoc false


  def render(assigns) do
    Phoenix.View.render(LearnSymbolsWeb.PageView, "profile_symbols_live.html", assigns)
  end

  def mount(%{user_id: user_id, symbols: symbols}, socket) do
    {:ok, assign(socket, user_id: user_id, symbols: symbols)}
  end

  def handle_event("delete-symbol", symbol_id, %{assigns: assigns} = socket) do
    Logger.debug symbol_id
    Logger.debug assigns
    {:noreply, assign(socket, assigns)}
  end

  def handle_event("validate", %{"create_symbol" => symbol}, %{assigns: assigns} = socket) do
    Logger.debug assigns
    {:noreply, assign(socket, assigns)}
  end

end

