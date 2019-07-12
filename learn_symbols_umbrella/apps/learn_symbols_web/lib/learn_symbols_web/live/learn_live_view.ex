defmodule LearnSymbolsWeb.LearnLiveView do
  use Phoenix.LiveView

  alias LearnSymbols

  @moduledoc false


  def render(assigns) do
    LearnSymbolsWeb.PageView.render("learn.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, _symbol} = LearnSymbols.get_symbol("123")
    {:ok, assign(socket, deploy_step: "Ready!")}
  end


end
