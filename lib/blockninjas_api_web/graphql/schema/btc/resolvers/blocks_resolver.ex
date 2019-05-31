defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Resolvers.BlocksResolver do
  @moduledoc """
  Resolver functions for blocks of the Bitcoin Blockchain.
  """

  alias BlockninjasApi.Repo
  alias BlockninjasApi.Btc.Block

  def list_blocks(args, _) do
    Block
    |> Ecto.Queryable.to_query()
    |> Absinthe.Relay.Connection.from_query(&Repo.all/1, args)
  end
end
