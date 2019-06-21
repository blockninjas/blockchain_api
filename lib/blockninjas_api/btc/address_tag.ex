defmodule BlockninjasApi.Btc.AddressTag do
  @moduledoc """
  Represents an address tag that corresponds to one or many addresses of the Bitcoin Blockchain.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias BlockninjasApi.Btc.Address

  schema "address_tags" do
    field(:title, :string, null: false)
    field(:priority, :integer, null: false)
    field(:category, :string, null: false)
    belongs_to(:address, Address)
  end

  @doc false
  def changeset(%AddressTag{} = address_tags, attrs) do
    address_tags
    |> cast(attrs, [:title, :priority, :category, :address_id])
    |> validate_required([:title, :priority, :address_id])
    |> foreign_key_constraint(:address_id)
  end
end
