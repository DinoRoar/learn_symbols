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
      render conn, "learn.html", %{symbol: symbol.symbol, symbol_id: symbol.id}
    else
      err -> err
    end
  end

  def answer(conn, %{"answer" => answer, "symbol_id" => symbol_id}) do
    user = conn.assigns[:current_user]
    answer_atom = case answer do
      "yes" -> :yes
      _ -> :no
    end

    with {:ok, _} <- LearnSymbols.answer(user.id, symbol_id, answer_atom),
         {:ok, symbol} = LearnSymbols.get_symbol(user.id)do
      render conn, "learn.html", %{symbol: symbol.symbol, symbol_id: symbol.id}
      else
      err -> err
    end
  end
end
