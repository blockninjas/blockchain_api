defmodule BlockninjasApi.Btc.OutputAddress do
  @moduledoc """
  Represents an output address of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Type.Hash
  alias BlockninjasApi.Btc.{Address, Output}

  @primary_key false
  schema "output_addresses" do
    belongs_to(:output, Output, primary_key: true)
    field(:hash, Hash, null: false)
    field(:base58check, :string, null: false)
    has_one(:address, Address, foreign_key: :base58check, references: :base58check)
  end

  @doc false
  def changeset(%OutputAddress{} = output_address, attrs) do
    output_address
    |> cast(attrs, [:output_id, :hash, :base58check])
    |> validate_required([:output_id, :hash, :base58check])
    |> foreign_key_constraint(:output_id)
  end
end
