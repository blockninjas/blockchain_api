defmodule BlockninjasApiWeb.Router do
  use BlockninjasApiWeb, :router

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

  scope "/", BlockninjasApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :api
    # pipe_through(:security)

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: BlockninjasApiWeb.Graphql.Schema
    forward "/", Absinthe.Plug, schema: BlockninjasApiWeb.Graphql.Schema
  end
end
