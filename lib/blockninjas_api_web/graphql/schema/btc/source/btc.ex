defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Source do
  @moduledoc """
  Source to help dataloader loading the Bitcoin database.
  """

  alias BlockninjasApi.Repo

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
