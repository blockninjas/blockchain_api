defmodule BlockninjasApi.Btc.Input do
  @moduledoc """
  Represents an input of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Btc.{Transaction, Address}

  schema "resolved_inputs" do
    field(:base58check, :string, null: false)
    field(:value, :integer, null: false)
    field(:script, :string, null: false)
    belongs_to(:transaction, Transaction)
    has_one(:address, Address, foreign_key: :base58check, references: :base58check)
  end

  @doc false
  def changeset(%Input{} = input, _attrs) do
    input
  end
end
