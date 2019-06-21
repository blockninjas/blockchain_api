defmodule BlockninjasApi.Btc.Transaction do
  @moduledoc """
  Represents a transaction of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Type.{Hash, SignedInteger}
  alias BlockninjasApi.Btc.Block
  alias BlockninjasApi.Btc.Output
  alias BlockninjasApi.Btc.Input

  schema "transactions" do
    field(:hash, Hash, null: false)
    field(:version, SignedInteger, null: false)
    field(:lock_time, SignedInteger, null: false)
    field(:size_in_bytes, :integer, null: false)
    field(:weight, :integer, null: false)
    belongs_to(:block, Block)
    has_many(:outputs, Output)
    has_many(:inputs, Input)
  end

  @doc false
  def changeset(%Transaction{} = transaction, attrs) do
    transaction
    |> cast(attrs, [:hash, :version, :lock_time, :size_in_bytes, :weight, :block_id])
    |> validate_required([:hash, :version, :lock_time, :size_in_bytes, :weight, :block_id])
    |> foreign_key_constraint(:block_id)
  end
end
