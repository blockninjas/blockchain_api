defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Relay do
  @moduledoc """
  Defines a node interface for our Relay schema providing a type resolver that,
  given a resolved object can determine which node object type it belongs to.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias BlockninjasApi.Btc.Block

  node interface do
    resolve_type(fn
      %Block{}, _ -> :block
    end)
  end
end