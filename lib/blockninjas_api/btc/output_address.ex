defmodule BlockninjasApi.Btc.OutputAddress do
  @moduledoc """
  Represents an output address of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Type.Hash
  alias BlockninjasApi.Btc.Address

  @primary_key false
  schema "output_addresses" do
    field(:output_id, :integer, null: false, primary_key: true)
    field(:hash, Hash, null: false)
    field(:base58check, :string, null: false)
    has_one(:address, Address, foreign_key: :base58check, references: :base58check)
  end

  @doc false
  def changeset(%OutputAddress{} = output, attrs) do
    output
    #address
    #|> cast(attrs, [:base58check, :cluster_representative])
    #|> validate_required([:base58check])
  end
end
