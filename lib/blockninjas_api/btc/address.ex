defmodule BlockninjasApi.Btc.Address do
  @moduledoc """
  Represents an address of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Btc.Cluster
  alias BlockninjasApi.Btc.AddressTag
  alias BlockninjasApi.Btc.Input
  alias BlockninjasApi.Btc.OutputAddress

  schema "addresses" do
    field(:base58check, :string, null: false)
    belongs_to(:cluster, Cluster, foreign_key: :cluster_representative)
    has_many(:address_tags, AddressTag)
    has_many(:outgoing, Input, foreign_key: :base58check, references: :base58check)
    has_many(:output_addresses, OutputAddress, foreign_key: :base58check, references: :base58check)
    has_many(:incoming, Input, foreign_key: :base58check, references: :base58check)
  end

  @doc false
  def changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, [:base58check, :cluster_representative])
    |> validate_required([:base58check])
  end
end
