defmodule BlockninjasApi.Btc.Output do
  @moduledoc """
  Represents an output of a transaction of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Type.Hash
  alias BlockninjasApi.Btc.{Transaction, OutputAddress}

  schema "outputs" do
    field(:output_index, :integer, null: false)
    field(:value, :integer, null: false)
    field(:script, Hash, null: false)
    belongs_to(:transaction, Transaction)
    has_one(:output_address, OutputAddress, foreign_key: :output_id)
    has_one(:address, through: [:output_address, :address])
  end

  @doc false
  def changeset(%Output{} = output, attrs) do
    output
    |> cast(attrs, [:output_index, :value, :script, :transaction_id])
    |> validate_required([:output_index, :value, :script, :transaction_id])
    |> foreign_key_constraint(:transaction_id)
  end
end
