defmodule BecomicsWeb.Router do
  use BecomicsWeb, :router

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

  scope "/", BecomicsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/comics", ComicHTMLController, :index
    # get "/comics/:day", ComicHTMLController, :show
    # form_for uses post
    post "/comics/:id", ComicHTMLController, :update
    get "/daily", DailyController, :daily
    # get "/sample/:date", SampleController, :sample
    get "/like/:like", LikeController, :like
  end

  # Other scopes may use custom stacks.
  scope "/api", BecomicsWeb do
    pipe_through :api
    resources "/comics", ComicController, except: [:new, :edit]
    resources "/publishes", PublishController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BecomicsWeb.Telemetry
    end
  end
end
