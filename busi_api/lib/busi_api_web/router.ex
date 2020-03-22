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
    get "/user/businesses/:id", UserController, :show
    put "/user/:id", UserController, :update
    get "/businesses", BusinessController, :index
    post "/businesses/create/:id", BusinessController, :create
    post "/businesses/add/:id_user/:id_event", BusinessController, :add
    post "/businesses/delete/:id_user/:id_event", BusinessController, :remove_in_user
    get "/businesses/:id", BusinessController, :show
    put "/businesses/:id", BusinessController, :update
    delete "/businesses/:id", BusinessController, :delete
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", BusiApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
end
