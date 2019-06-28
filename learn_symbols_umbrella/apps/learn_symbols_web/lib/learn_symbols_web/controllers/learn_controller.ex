defmodule LearnSymbolsWeb.LearnController do
  use LearnSymbolsWeb, :controller


  def start(conn, %{"name" => name}) do
    with {:ok, profile} <- LearnSymbols.init_profile(name, "1234")
      do
      render(conn, "learn.html", profile: profile)
    else
      err -> err
    end

  end

end
