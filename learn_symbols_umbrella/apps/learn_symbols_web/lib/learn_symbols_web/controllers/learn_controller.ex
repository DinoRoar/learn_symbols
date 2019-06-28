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

    user = conn.assigns[:current_user]
    Logger.debug(Poison.encode!(user))

    render conn, "learn.html", current_user: user
  end

end
