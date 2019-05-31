defmodule BlockninjasApiWeb.Graphql.Schema.Btc.Resolvers.AddressesResolver do
  @moduledoc """
  Resolver functions for addresses of the Bitcoin Blockchain.
  """

  alias BlockninjasApi.Btc

  def find_address(_parent, %{base58check: base58check}, _resolution) do
    case Btc.get_address(base58check) do
      nil ->
        {:error, "Address for base58check #{base58check} not found"}
      address ->
        {:ok, address}
    end
  end
end
