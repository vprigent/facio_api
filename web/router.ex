defmodule FacioApi.Router do
  use FacioApi.Web, :router

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

  scope "/", FacioApi do
    pipe_through :api

    resources "/lists", ListController, except: [:new, :edit]
  end

  scope "/", Shield do
    pipe_through :api
    resources "/clients", ClientController, except: [:new, :edit]

    get     "/apps", AppController, :index
    get     "/apps/:id", AppController, :show
    delete  "/apps/:id", AppController, :delete
    post    "/apps/authorize", AppController, :authorize

    get     "/tokens/:id", TokenController, :show
    post    "/tokens", TokenController, :create

    post    "/users/register", UserController, :register
    post    "/users/login", UserController, :login
    delete  "/users/logout", UserController, :logout
    get     "/users/me", UserController, :me
    get     "/users/confirm", UserController, :confirm
    post    "/users/recover_password", UserController, :recover_password
    post    "/users/reset_password", UserController, :reset_password
    post    "/users/change_password", UserController, :change_password

    get     "/settings", SettingController, :index
    put     "/settings/:id", SettingController, :update
    patch   "/settings/:id", SettingController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", FacioApi do
  #   pipe_through :api
  # end
end
