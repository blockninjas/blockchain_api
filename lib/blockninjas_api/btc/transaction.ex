defmodule BlockninjasApi.Btc.Transaction do
  @moduledoc """
  Represents a transaction of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Type.{Hash, SignedInteger}
  alias BlockninjasApi.Btc.Block

  schema "transactions" do
    field(:hash, Hash, null: false)
    field(:version, SignedInteger, null: false)
    field(:lock_time, SignedInteger, null: false)
    field(:size_in_bytes, :integer, null: false)
    belongs_to(:block, Block)
#    has_many(:inputs, Input)
#    has_many(:outputs, Output)
#    has_one(:output, Output) # used for inputs
  end

  @doc false
  def changeset(%Transaction{} = transaction, attrs) do
    transaction
    |> cast(attrs, [:hash, :version, :lock_time, :size_in_bytes, :block_id])
    |> validate_required([:hash, :version, :lock_time, :size_in_bytes, :block_id])
    |> foreign_key_constraint(:block_id)
  end
end
