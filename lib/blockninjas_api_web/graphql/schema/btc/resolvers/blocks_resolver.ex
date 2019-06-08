defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Resolvers.BlocksResolver do
  @moduledoc """
  Resolver functions for blocks of the Bitcoin Blockchain.
  """

  alias BlockninjasApi.Repo
  alias BlockninjasApi.Btc
  alias BlockninjasApi.Btc.Block

  def list_blocks(pagination_args, _) do
    Block
    |> Ecto.Queryable.to_query()
    |> Absinthe.Relay.Connection.from_query(&Repo.all/1, pagination_args)
  end

  def find_block(_parent, %{hash: hash}, _resolution) do
    case Btc.get_block_by_hash(hash) do
      nil ->
        {:error, "Block for hash #{hash} not found"}
      block ->
        {:ok, block}
    end
  end

  def find_block(_parent, %{height: height}, _resolution) do
    case Btc.get_block_by_height(height) do
      nil ->
        {:error, "Block for height #{height} not found"}
      block ->
        {:ok, block}
    end
  end

  def find_block(_parent, _, _resolution), do: {:error, "Hash or height must be provided as argument"}
end
