defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Types.ClusterTypes do
  @moduledoc """
  Specifies Bitcoin clusters as nodes that can be accessed via GraphQL.
  Additional support for the Relay specification when prefixed with the `node` macro.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias BlockninjasApiWeb.Graphql.Schema.Btc.Source, as: BtcSource
  alias BlockninjasApiWeb.Graphql.Schema.Btc.Resolvers.AddressesResolver

  @desc "A Bitcoin cluster"
  node object(:cluster) do
    connection field(:addresses, node_type: :address, description: "Addresses within this cluster.") do
      resolve(&AddressesResolver.find_addresses/2)
    end
    field(:addresses, list_of(:address), resolve: dataloader(BtcSource))
    field(:tags, list_of(:tag), resolve: dataloader(BtcSource))
  end

  object :btc_cluster_queries do
    @desc "Query an address by its base58check"
    field :cluster, :cluster do
      arg(:base58check, non_null(:string))
      resolve(&AddressesResolver.find_address/3)
    end
  end

  connection(node_type: :address) do
    field :count, :integer do
      resolve fn
        _, %{source: conn} ->
          # TODO: replace this resolver function with a database aggregation query
          {:ok, length(conn.edges)}
      end
    end

    edge do
      # Just remember that if you use the block form of connection, you must call the edge macro within the block.
      # see also https://hexdocs.pm/absinthe_relay/Absinthe.Relay.Connection.html
    end
  end
end
