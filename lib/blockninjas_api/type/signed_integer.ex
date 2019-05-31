defmodule BlockninjasApi.Type.SignedInteger do
  @moduledoc """
  Provides capability for storing signed integer values in the database.
  """

  @behaviour Ecto.Type
  def type, do: :integer

  def cast(int) when is_integer(int), do: {:ok, int}

  def cast(int) when is_binary(int) do
    case Integer.parse(int) do
      :error ->
        :error

      {parsed, _} ->
        {:ok, parsed}
    end
  end

  def cast(_), do: :error

  # When loading data from the database, we are guaranteed to
  # receive an signed integer (as databases are strict) and we will
  # just put the data back into an unsigned integer to be stored
  # in the loaded schema struct.
  def load(signed_int) do
    {:ok, convert_signed_to_unsigned(signed_int)}
  end

  # When dumping data to the database, we *expect* an integer
  # but any value could be inserted into the schema struct at runtime,
  # so we need to guard against them.
  def dump(unsigned_int) when is_integer(unsigned_int),
    do: {:ok, convert_unsigned_to_signed(unsigned_int)}

  def dump(_), do: :error

  # Converts an unsigned integer to a signed integer.
  defp convert_unsigned_to_signed(unsigned_integer) do
    <<signed_integer::integer-signed-32>> = <<unsigned_integer::integer-unsigned-32>>
    signed_integer
  end

  # Converts a signed integer to an unsigned integer.
  defp convert_signed_to_unsigned(signed_integer) do
    <<unsigned_signed_integer::integer-unsigned-32>> = <<signed_integer::integer-signed-32>>
    unsigned_signed_integer
  end
end
