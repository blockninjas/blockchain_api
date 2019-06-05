defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Types.BlockTypes do
  @moduledoc """
  Specifies Bitcoin blocks as nodes that can be accessed via GraphQL.
  Additional support for the Relay specification when prefixed with the `node` macro.
  """

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias BlockninjasApiWeb.Graphql.Schema.Btc.Source, as: BtcSource
  alias BlockninjasApiWeb.Graphql.Schema.Btc.Resolvers.BlocksResolver

  @desc "A Bitcoin block"
  node object(:block) do
    field(:hash, non_null(:string))
    field(:version, non_null(:integer))
    field(:merkle_root, non_null(:string))

    field(:creation_time, non_null(:naive_datetime),
      description: "Timestamp when the block has been created in ISO8601 format"
    )

    field(:nonce, non_null(:integer), description: "Nonce of the block")
    field(:height, non_null(:integer), description: "Actual height of the block")
    field(:transactions, list_of(:transaction), resolve: dataloader(BtcSource))
    field(:next_block, :block, resolve: dataloader(BtcSource))

    #    field :gravatar_md5, :string do
    #      resolve(fn user, _, _ ->
    #        {:ok, :crypto.hash(:md5, user.email) |> Base.encode16(case: :lower)}
    #      end)
    #    end
  end

  connection(node_type: :block)

  object(:btc_block_queries) do
    @desc "Query a block by either the hash or the height of the block."
    field :block, :block do
      arg(:hash, :string)
      arg(:height, :integer)
      resolve(&BlocksResolver.find_block/3)
    end

    connection field(:blocks, node_type: :block) do
      resolve(&BlocksResolver.list_blocks/2)
    end
  end

  #
  #  object :btc_block_queries do
  #    @desc "Get a BTC block by its base58check address"
  #    field :block, :block do
  #      arg(:base58check, non_null(:string))
  #      resolve(dataloader(Btc))
  #    end
  #  end

  #
  #  object :user_queries do
  #    @desc "Search users"
  #    field :search_users, list_of(:user) do
  #      arg(:search_term, non_null(:string))
  #
  #      resolve(&Resolvers.UserResolver.search_users/3)
  #    end
  #
  #    @desc "Get current user"
  #    field :current_user, :user do
  #      resolve(&Resolvers.UserResolver.current_user/3)
  #    end
  #  end
  #
  #  object :user_mutations do
  #    @desc "Authenticate"
  #    field :authenticate, :user do
  #      arg(:email, non_null(:string))
  #      arg(:password, non_null(:string))
  #
  #      resolve(&Resolvers.UserResolver.authenticate/3)
  #    end
  #
  #    @desc "Sign up"
  #    field :sign_up, :user do
  #      arg(:name, non_null(:string))
  #      arg(:email, non_null(:string))
  #      arg(:password, non_null(:string))
  #
  #      resolve(&Resolvers.UserResolver.signup/3)
  #    end
  #  end
end
