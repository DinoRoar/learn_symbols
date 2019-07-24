defmodule LearnSymbolsWeb.ProfileController do
  use LearnSymbolsWeb, :controller
  alias LearnSymbols

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

  def profile(conn, _params) do
    with user <- conn.assigns[:current_user],
         {:ok, profile} <- LearnSymbols.get_user_profile(user.id) do
      render conn, "profile.html", %{profile: profile}
    else
      err -> err
    end
  end
end
