defmodule BlockninjasApiWeb.Graphql.Schema do
  @moduledoc """
  Module for defining the GraphQL schema.
  """

  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  import_types(Absinthe.Type.Custom)
  import_types(__MODULE__.Btc.Relay)
  import_types(__MODULE__.Btc.Types.BlockTypes)
  import_types(__MODULE__.Btc.Types.TransactionTypes)
  import_types(__MODULE__.Btc.Types.AddressTypes)
  import_types(__MODULE__.Btc.Types.ClusterTypes)

  alias __MODULE__.Btc.Source, as: BtcSource

  query do
    # Imports all queries that are specified within objects of the already imported types from above.
    import_fields(:btc_block_queries)
    import_fields(:btc_address_queries)
  end

  @impl true
  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(BtcSource, BtcSource.data())

    Map.put(ctx, :loader, loader)
  end

  @impl true
  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
