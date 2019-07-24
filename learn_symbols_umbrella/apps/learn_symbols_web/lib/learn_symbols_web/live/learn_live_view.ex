defmodule LearnSymbolsWeb.LearnLiveView do
  use Phoenix.LiveView

  alias LearnSymbols

  require Logger
  require Poison

  @moduledoc false


  def render(assigns) do
    Phoenix.View.render(LearnSymbolsWeb.PageView, "learn_live.html", assigns)
  end

  def mount(%{user_id: user_id, symbols: symbols}, socket) do
    {:ok, assign(socket, user_id: user_id, symbols: symbols)}
  end


end

