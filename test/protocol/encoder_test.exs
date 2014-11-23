defmodule EncoderTest do
  use ExUnit.Case
  import Asterix.Protocol.Encoder

  test "Encoder encodes an empty string" do
    assert (string "") == <<0, 0>>
  end

  test "Encoder encodes an empty array" do
    assert array([], &int32/1) == <<0, 0, 0, 0>>
  end

  test "Encoder encodes array" do
    data = array [1, 2, 3, 4], &int16/1
    assert data == <<0, 0, 0, 4, 0, 1, 0, 2, 0, 3, 0, 4>>
  end

  test "Encoder encodes a non-empty string" do
    assert (string "hej") == <<0, 3, 104, 101, 106>>
  end
end
