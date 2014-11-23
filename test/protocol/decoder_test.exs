defmodule DecoderTest do
  use ExUnit.Case
  import Asterix.Protocol.Decoder

  test "Decoder decodes an encoded string" do
    {s, rest} = string(<<0, 3, 104, 101, 106>>)
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

      {numbers, b} = int32_array(data)
    assert numbers == [1, 2, 3, 4]
    assert b == <<>>
  end
end
