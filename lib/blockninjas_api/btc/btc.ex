defmodule BlockninjasApi.Btc do
  @moduledoc """
  The Bitcoin context.
  """

  import Ecto.Query, warn: false

  alias BlockninjasApi.Repo
  alias BlockninjasApi.Btc.{Block, Address}

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
    |> join(:left, [block], next_block in assoc(block, :next_block))
    |> preload([..., next_block], next_block: next_block)
    |> Repo.get_by!(hash: hash)
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
end