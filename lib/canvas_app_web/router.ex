defmodule CanvasAppWeb.Router do
  use CanvasAppWeb, :router

  import CanvasAppWeb.AccountAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CanvasAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_account
  end

  pipeline :admin do
    plug CanvasAppWeb.Plugs.AdminAuth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CanvasAppWeb do
    pipe_through :browser

    live "/locations", LocationLive.Index, :index
    live "/locations/new", LocationLive.Index, :new

    live "/locations/:id", LocationLive.Show, :show
    live "/locations/:id/edit", LocationLive.Show, :edit

    #live "/", LocationLive.Index, :index
    live "/", LandingLive.Index, :index

    live "/users", UserLive.Index, :index
    live "/users/new", UserLive.Index, :new

  end


  if Application.compile_env(:canvas_app, :dev_routes) do

    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CanvasAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", CanvasAppWeb do
    pipe_through [:browser, :redirect_if_account_is_authenticated]

    live_session :redirect_if_account_is_authenticated,
      on_mount: [{CanvasAppWeb.AccountAuth, :redirect_if_account_is_authenticated}] do
      live "/accounts/register", AccountRegistrationLive, :new
      live "/accounts/log_in", AccountLoginLive, :new
      live "/accounts/reset_password", AccountForgotPasswordLive, :new
      live "/accounts/reset_password/:token", AccountResetPasswordLive, :edit
    end

    post "/accounts/log_in", AccountSessionController, :create
  end

  scope "/", CanvasAppWeb do
    pipe_through [:browser, :require_authenticated_account ]

    live_session :require_authenticated_account,
      on_mount: [{CanvasAppWeb.AccountAuth, :ensure_authenticated}] do
      live "/accounts/settings", AccountSettingsLive, :edit
      live "/accounts/settings/confirm_email/:token", AccountSettingsLive, :confirm_email

     # live "/admin", AdminIndexLive
    end
  end

  scope "/", CanvasAppWeb do
    pipe_through [:browser, :require_authenticated_account, :admin]

      live "/admin", AccountLive.Admin.AdminIndexLive
      live "/admin/dashboard", AccountLive.Admin.AdminDashboardLive
      live "/admin/members", UserLive.Import, :import
      live "/admin/projects", ProjectLive.Index, :index
      live "/admin/projects/new", ProjectLive.Index, :new


  end

  scope "/", CanvasAppWeb do
    pipe_through [:browser]

    get "/sample-csv", CsvController, :index
    live "/users/import", UserLive.Import, :import
  end


  scope "/", CanvasAppWeb do
    pipe_through [:browser]

    delete "/accounts/log_out", AccountSessionController, :delete

    live_session :current_account,
      on_mount: [{CanvasAppWeb.AccountAuth, :mount_current_account}] do
      live "/accounts/confirm/:token", AccountConfirmationLive, :edit
      live "/accounts/confirm", AccountConfirmationInstructionsLive, :new
    end
  end
end
