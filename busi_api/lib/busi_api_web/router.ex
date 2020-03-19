defmodule BusiApiWeb.Router do
  use BusiApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BusiApiWeb.Auth.Pipeline
  end

  scope "/api", BusiApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
    post "/users/signout", UserController, :signout
  end

  scope "/api", BusiApiWeb do
    pipe_through [:api, :auth]
    get "/businesses", BusinessController, :index
    post "/businesses/create/:id", BusinessController, :create
    get "/businesses/:id", BusinessController, :show
    put "/businesses/:id", BusinessController, :update
    delete "/businesses/:id", BusinessController, :delete
    post "/businesses/add/:id_user/:id_event", BusinessController, :insert_user_event
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", BusiApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
end
