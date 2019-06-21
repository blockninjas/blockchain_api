defmodule BlockninjasApi.Btc.Block do
  @moduledoc """
  Represents a block of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Type.{Hash, SignedInteger, UnixTimestamp}
  alias BlockninjasApi.Btc.{Transaction}

  schema "blocks" do
    field(:hash, Hash, null: false)
    field(:version, SignedInteger, null: false)
    field(:previous_block_hash, Hash, null: false)
    field(:merkle_root, Hash, null: false)
    field(:creation_time, UnixTimestamp, null: false)
    field(:nonce, SignedInteger, null: false)
    field(:height, :integer)
    has_many(:transactions, Transaction)
    has_one(:next_block, Block, references: :hash, foreign_key: :previous_block_hash)
  end

  @doc false
  def changeset(%Block{} = block, attrs) do
    block
    |> cast(attrs, [
      :hash,
      :version,
      :previous_block_hash,
      :merkle_root,
      :creation_time,
      :nonce,
      :height
    ])
    |> validate_required([
      :hash,
      :version,
      :previous_block_hash,
      :merkle_root,
      :creation_time,
      :nonce,
      :height
    ])
    |> validate_number(:height, greater_than_or_equal_to: 0)
  end
end
