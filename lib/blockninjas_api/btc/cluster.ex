defmodule BlockninjasApi.Btc.Cluster do
  @moduledoc """
  Represents an address of the Bitcoin Blockchain.

  This schema is actually based on the same physical database table as the `address` schema
  but it helps to make code more readable in order to easier differentiate between an address
  and a cluster from a domain perspective.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Btc.Address

  schema "addresses" do
    field(:base58check, :string, null: false)
    has_many(:addresses, Address, foreign_key: :cluster_representative)
    has_many(:tags, through: [:addresses, :address_tags])
  end

  @doc false
  def changeset(%Cluster{} = cluster, attrs) do
    cluster
    |> cast(attrs, [:base58check, :cluster_representative])
    |> validate_required([:base58check])
  end
end
