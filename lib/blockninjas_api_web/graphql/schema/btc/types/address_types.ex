defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Types.AddressTypes do
  @moduledoc """
  Specifies Bitcoin addresses as nodes that can be accessed via GraphQL.
  Additional support for the Relay specification when prefixed with the `node` macro.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias BlockninjasApiWeb.Graphql.Schema.Btc.Source, as: BtcSource
  alias BlockninjasApiWeb.Graphql.Schema.Btc.Resolvers.AddressesResolver

  @desc "A Bitcoin address"
  node object(:address) do
    field(:base58check, non_null(:string))
    field(:cluster, non_null(:cluster), resolve: dataloader(BtcSource))
    field(:address_tags, list_of(:address_tag), resolve: dataloader(BtcSource))
  end

  @desc "A tag for an address"
  node object(:address_tag) do
    field(:title, non_null(:string))
    field(:priority, non_null(:integer))
    field(:category, :string, description: "Category for that tag such as gambling, scam, exchange, and more.")
  end

  object :btc_address_queries do
    @desc "Query an address by its base58check"
    field :address, :address do
      arg(:base58check, non_null(:string))
      resolve(&AddressesResolver.find_address/3)
    end
  end

#  connection(node_type: :address)
#
#  object(:btc_address_queries) do
#    connection field(:addresses, node_type: :address) do
#      resolve(&BlocksResolver.list_blocks/2)
#    end
#  end

  #
end
