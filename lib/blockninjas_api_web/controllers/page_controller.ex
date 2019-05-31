defmodule BlockninjasApiWeb.PageController do
  use BlockninjasApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
