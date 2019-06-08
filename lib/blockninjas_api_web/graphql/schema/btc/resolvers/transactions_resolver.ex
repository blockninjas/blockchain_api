defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Resolvers.TransactionsResolver do
  @moduledoc """
  Resolver functions for transactions of the Bitcoin Blockchain.
  """

  alias BlockninjasApi.{Repo, Btc}

  def find_transactions(pagination_args, %{source: block}) do
    block.id
    |> Btc.get_transactions_by_block_id()
    |> Ecto.Queryable.to_query()
    |> Absinthe.Relay.Connection.from_query(&Repo.all/1, pagination_args)
  end
end
