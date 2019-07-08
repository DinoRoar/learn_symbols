defmodule LearnSymbolsWeb.LearnController do
  use LearnSymbolsWeb, :controller

  require Logger
  require Poison

  plug :secure

  defp secure(conn, _params) do
    user = get_session(conn, :current_user)
    case user do
      nil ->
        conn
        |> redirect(to: "/auth/auth0")
        |> halt
      _ ->
        conn
        |> assign(:current_user, user)
    end
  end

  def start(conn, _params) do
    with user <- conn.assigns[:current_user],
         {:ok, symbol} <- LearnSymbols.get_symbol(user.id) do
      render conn, "learn.html", symbol: symbol
    else
      err -> err
    end
  end

  def answer(conn, params) do
    Logger.debug(Poison.encode!(params))
  end
end
