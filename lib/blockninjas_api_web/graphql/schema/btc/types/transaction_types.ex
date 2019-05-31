defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Types.TransactionTypes do
  @moduledoc """
  Specifies Bitcoin transactions as nodes that can be accessed via GraphQL.
  Additional support for the Relay specification when prefixed with the `node` macro.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias BlockninjasApiWeb.Graphql.Schema.Btc.Source, as: BtcSource

  @desc "A Bitcoin transaction"
  node object(:transaction) do
    field(:hash, non_null(:string))
    field(:block, non_null(:block), resolve: dataloader(BtcSource))
  end
end
