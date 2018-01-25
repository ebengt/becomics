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
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/comics", ComicHTMLController, :index
    get "/comics/:day", ComicHTMLController, :show
    # form_for uses post
    post "/comics/:id", ComicHTMLController, :update
    #get "/daily", DailyController, :daily
    #get "/sample/:date", SampleController, :sample
  end

  # Other scopes may use custom stacks.
   scope "/api", BecomicsWeb do
     pipe_through :api
     resources "/comics", ComicController, except: [:new, :edit]
     resources "/publishes", PublishController, except: [:new, :edit]
   end
end
