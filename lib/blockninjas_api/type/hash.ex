defmodule BlockninjasApi.Type.Hash do
  @moduledoc """
  Provides capability for storing hash (Base-16 hex byte array) values in the database.
  """

  @behaviour Ecto.Type
  def type, do: :binary

  def cast(hash) when is_binary(hash), do: {:ok, hash}
  def cast(_), do: :error

  # When loading data from the database, we are guaranteed to
  # receive a byte array (as databases are strict) and we will
  # just put the data back into a string to be stored
  # in the loaded schema struct.
  def load(byte_array) do
    {:ok, Base.encode16(byte_array, case: :lower)}
  end

  # When dumping data to the database, we *expect* a string
  # but any value could be inserted into the schema struct at runtime,
  # so we need to guard against them.
  def dump(t) when is_binary(t), do: Base.decode16(t, case: :lower)
  def dump(_), do: :error
end
