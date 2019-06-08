defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Resolvers.AddressesResolver do
  @moduledoc """
  Resolver functions for addresses of the Bitcoin Blockchain.
  """

  alias BlockninjasApi.{Repo, Btc}

  def find_address(_parent, %{base58check: base58check}, _resolution) do
    case Btc.get_address(base58check) do
      nil ->
        {:error, "Address for base58check #{base58check} not found"}
      address ->
        {:ok, address}
    end
  end

  def find_addresses(pagination_args, %{source: cluster}) do
    cluster.id
    |> Btc.get_addresses_by_cluster_representative()
    |> Ecto.Queryable.to_query()
    |> Absinthe.Relay.Connection.from_query(&Repo.all/1, pagination_args)
  end

  def find_tags_by_cluster(cluster, _, _resolution) do
    tags =
      cluster.id
      |> Btc.get_tags_by_cluster_representative()
      |> Repo.all()

    {:ok, tags}
  end
end
