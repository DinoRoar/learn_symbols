defmodule LearnSymbolsWeb.ProfileController do
  use LearnSymbolsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
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
