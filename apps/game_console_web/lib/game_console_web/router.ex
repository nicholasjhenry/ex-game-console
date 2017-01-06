defmodule GameConsoleWeb.Router do
  use GameConsoleWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "js"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :stuff
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GameConsoleWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/players", PlayerController, only: [:new, :create, :show] do
      resources "/hits", HitController, only: [:create]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", GameConsoleWeb do
  #   pipe_through :api
  # end
  #
  def stuff(conn, _) do
    get_session(conn, :game_token)
    |> IO.inspect
    token = case get_session(conn, :game_token) do
      nil -> UUID.uuid1
      token -> token
    end

    conn
    |> put_session(:game_token, token)
    |> assign(:game_token, token)
  end
end
