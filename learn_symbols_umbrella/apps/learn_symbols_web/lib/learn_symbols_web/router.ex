defmodule LearnSymbolsWeb.Router do
  @moduledoc false
  use LearnSymbolsWeb, :router

  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LearnSymbolsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/profile", ProfileController, :profile


    get "/start", LearnController, :start
    get "/logout", AuthController, :logout
    post "/answer", LearnController, :answer
  end

  scope "/auth", LearnSymbolsWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback

  end

  # Other scopes may use custom stacks.
  # scope "/api", LearnSymbolsWeb do
  #   pipe_through :api
  # end
end
