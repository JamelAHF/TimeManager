defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TimeManagerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug,
      origins: "*",
      allow_headers: ["accept", "content-type", "authorization", "contenttype"],
      allow_credentials: true,
      log: [rejected: :error, invalid: :warn, accepted: :debug]
  end


  pipeline :auth do
    plug TimeManagerWeb.JWTAuthPlug
    #plug TimeManagerWeb.ManagerPlug
  end

  pipeline :admin do
    plug TimeManagerWeb.JWTAuthPlug
    plug TimeManagerWeb.AdminPlug
  end

  scope "/api", TimeManagerWeb do
    pipe_through :admin
    get "/", PageController, :index




  end

  scope "/api/auth", TimeManagerWeb do
    pipe_through :api
    post "/users/login", UserController, :login #ok
    post "/users/register", UserController, :register #ok


  end


  scope "/api", TimeManagerWeb do
    pipe_through :auth

    #get "/users", UserController, :get_curr_usr

    get "/clock", ClockController, :show_last_clock #ok
    post "/clock", ClockController, :create_clock_by_token #ok
    get "/user", UserController, :get_curr_usr
    put "/users/:user_id/", UserController, :update
    delete "/users/:id", UserController, :delete #ok

    resources "/workingtimes", WorkingTimeController
    get "/workingtimes/:userID/", WorkingTimeController, :show_by_user
    get "/workingtimes_by_team/:team_id", WorkingTimeController, :show_by_team
    post "/workingtimes/get_interval", WorkingTimeController, :show_by_params
    post "/workingtimes/get_interval_team", WorkingTimeController, :get_by_team

    post "/workingtimes", WorkingTimeController, :create #ok

    put "/workingtimes/:id_user/:workingtimesid/:start/:end", WorkingTimeController , :update_by_params
    delete "/workingtimes/:id_user/:workingtimesid", WorkingTimeController , :delete_by_params

    post "/user_list/", UserController, :get_user_from_id_list
    resources "/team", TeamController
    resources "/group", GroupController

    get "/workingtimes/:id_user/:start/:end", WorkingTimeController , :get_by_userparams


  end

  # Other scopes may use custom stacks.
  # scope "/api", TimeManagerWeb do
  #   pipe_through :api
  # end

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

      live_dashboard "/dashboard", metrics: TimeManagerWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
