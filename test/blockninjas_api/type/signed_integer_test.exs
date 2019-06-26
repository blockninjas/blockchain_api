defmodule BlockninjasApi.Type.SignedIntegerTest do
  use ExUnit.Case
  alias BlockninjasApi.Type.SignedInteger

  test "cast integer" do
    assert SignedInteger.cast("2") == {:ok, 2}
    assert SignedInteger.cast(2) == {:ok, 2}
    assert SignedInteger.cast("S") == :error
    assert SignedInteger.cast(:ok) == :error
  end

  test "load signed integer" do
    assert SignedInteger.load(2083236893) == {:ok, 2083236893}
    assert SignedInteger.load(0) == {:ok, 0}
  end

  test "dump unsigned integer" do
    assert SignedInteger.dump(100) == {:ok, 100}
    assert SignedInteger.dump("S") == :error
  end
end