defmodule LearnSymbolsWeb.Router do
  use LearnSymbolsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LearnSymbolsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/profile/:name/:code", ProfileController, :profile


    get "/start/:name", LearnController, :start
  end

  # Other scopes may use custom stacks.
  # scope "/api", LearnSymbolsWeb do
  #   pipe_through :api
  # end
end
