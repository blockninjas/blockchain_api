defmodule BlockninjasApi.Btc.Address do
  @moduledoc """
  Represents an address of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "addresses" do
    field(:base58check, :string, null: false)
    belongs_to(:cluster, Address, foreign_key: :cluster_representative)
  end

  @doc false
  def changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, [:base58check, :cluster_representative])
    |> validate_required([:base58check])
  end
end
