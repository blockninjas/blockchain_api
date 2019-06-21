defmodule BlockninjasApi.Btc do
  @moduledoc """
  The Bitcoin context.
  """

  import Ecto.Query, warn: false

  alias BlockninjasApi.Repo
  alias BlockninjasApi.Btc.{Block, Transaction, Address, AddressTag}

  @doc """
  Gets a single block.

  Raises `Ecto.NoResultsError` if the block does not exist.

  ## Examples

      iex> get_block!(123)
      %Block{}

      iex> get_block!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_block!(String.t()) :: %Block{}
  def get_block!(hash) do
    Block
    |> with_next_block()
    |> Repo.get_by!(hash: hash)
  end

  @spec get_block_by_height(String.t()) :: %Block{} | nil
  def get_block_by_hash(hash) do
    Block
    |> with_next_block()
    |> Repo.get_by(hash: hash)
  end

  @spec get_block_by_height(integer) :: %Block{} | nil
  def get_block_by_height(height) do
    Block
    |> with_next_block()
    |> Repo.get_by(height: height)
  end

  @spec with_next_block(Block) :: Ecto.Query.t
  defp with_next_block(query) do
    query
    |> join(:left, [block], next_block in assoc(block, :next_block))
    |> preload([..., next_block], next_block: next_block)
  end

  @doc """
  Gets a single address.

  Returns `nil` if the given address does not exist.

  ## Examples

      iex> get_address(123)
      %Address{}

      iex> get_address(456)
      nil

  """
  @spec get_address(String.t()) :: %Address{} | nil
  def get_address(base58check) do
    Address
    |> Repo.get_by(base58check: base58check)
  end

  @spec get_addresses_by_cluster_representative(integer) :: Ecto.Query.t
  def get_addresses_by_cluster_representative(cluster_representative) do
    Address
    |> where(cluster_representative: ^cluster_representative)
  end

  @spec get_tags_by_cluster_representative(integer) :: Ecto.Query.t
  def get_tags_by_cluster_representative(cluster_representative) do
    AddressTag
    |> join(:inner, [tag], address in assoc(tag, :address))
    |> preload(:address)
    |> where([_, address], address.cluster_representative == ^cluster_representative)
  end

  @spec get_transactions_by_block_id(integer) :: Ecto.Query.t
  def get_transactions_by_block_id(block_id) do
    Transaction
    |> where(block_id: ^block_id)
  end
end