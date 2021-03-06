defmodule BusiApiWeb.Router do
  use BusiApiWeb, :router

  pipeline :auth do
    plug BusiApiWeb.Auth.Pipeline
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", BusiApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create

    options "/users/signin", UserController, :options
    post "/users/signin", UserController, :signin
    options "/users/renew", UserController, :options
    post "/users/renew", UserController, :renew
  end

  scope "/api", BusiApiWeb do
    pipe_through [:api, :auth]
    resources "/businesses", BusinessController, except: [:new, :edit]
    options   "/businesses", BusinessController, :options
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", BusiApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
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
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: BusiApiWeb.Telemetry
    end
  end
end
