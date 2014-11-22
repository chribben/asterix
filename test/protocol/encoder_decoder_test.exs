defmodule EncoderDecoderTest do
  use ExUnit.Case
  alias Asterix.Protocol.Encoder
  alias Asterix.Protocol.Decoder

  test "Encoder encodes an empty string" do
    assert (Encoder.string "") == <<0, 0>>
  end


  test "Encoder encodes an empty array" do
    assert Encoder.array([], &Encoder.int32/1) == <<0, 0, 0, 0>>
  end

  test "Encoder encodes array" do
    data = Encoder.array [1, 2, 3, 4], &Encoder.int16/1
    assert data == <<0, 0, 0, 4, 0, 1, 0, 2, 0, 3, 0, 4>>
  end

  test "Encoder encodes a non-empty string" do
    assert (Encoder.string "hej") == <<0, 3, 104, 101, 106>>
  end

  test "Decoder decodes an encoded string" do
    {s, rest} = Decoder.decode_string(<<0, 3, 104, 101, 106>>)
    assert s == "hej"
    assert rest == <<>>
  end

  test "Decoder decoes an int32 array" do
    data =
    <<0, 0, 0, 4>> <> # length
    <<0, 0, 0, 1>> <>
    <<0, 0, 0, 2>> <>
    <<0, 0, 0, 3>> <>
    <<0, 0, 0, 4>>

      {numbers, b} = Decoder.decode_int32_array(data)
    assert numbers == [1, 2, 3, 4]
    assert b == <<>>
  end
end
