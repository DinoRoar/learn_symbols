defmodule LearnSymbolsWeb.ProfileController do
  use LearnSymbolsWeb, :controller

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

  def profile(conn, %{"name" => name, "code" => code}) do
    with {:ok, profile} <- LearnSymbols.init_profile(name, code)
      do
      render(conn, "profile.html", profile: profile)
    else
      err -> err
    end
  end
end
