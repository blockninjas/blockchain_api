defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Types.InputTypes do
  @moduledoc """
  Specifies Bitcoin input as nodes that can be accessed via GraphQL.
  Additional support for the Relay specification when prefixed with the `node` macro.

  alternative:
  query {
  address(base58check: "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa") {
    base58check

    outgoing(first: 2) { # with relay?
      aggregation {
        sum
        count
        firstOccurence
        lastOccurence
      }
      edges {
        node {
          value
          addresses {
            base58check
          }
        }
      }
    }
  }

  NEW API:
  ---
  query($address: String!) {
    address(base58check: $address) {
      incoming {
        value
        transaction {
          hash
          outputs {
            address { # 0 .. 1
              base58check
            }
          }
          inputs {
            address { # 0 .. 1
              base58check
            }
          }
        }
      }

      outgoing {
        value
        transaction {
          hash
          outputs {
            address { # 0 .. 1
              base58check
            }
          }

          inputs {
            address { # 0 .. 1
              base58check
            }
          }
        }
      }
    }
  }
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias BlockninjasApiWeb.Graphql.Schema.Btc.Source, as: BtcSource

  @desc "Outgoing transactions from a Bitcoin address"
  node object(:outgoing) do
    field(:value, non_null(:integer), description: "Satoshi")
    field(:transaction, non_null(:transaction), resolve: dataloader(BtcSource))
  end

  @desc "Incoming transactions to a Bitcoin address"
  node object(:incoming) do
    field(:value, non_null(:integer), description: "Satoshi")
    field(:transaction, non_null(:transaction), resolve: dataloader(BtcSource))
  end

  ### NEW

  node object(:input) do
    # TODO: input and outgoing is the same - explicit here just to avoid confusion
    field(:value, non_null(:integer), description: "Satoshi")
    field(:address, :address, resolve: dataloader(BtcSource))
  end

  node object(:output) do
    # TODO: output and incoming is the same - explicit here just to avoid confusion
    field(:value, non_null(:integer), description: "Satoshi")
    field(:address, :address, resolve: dataloader(BtcSource))
  end
end
