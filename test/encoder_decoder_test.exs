defmodule EncoderDecoderTest do
  use ExUnit.Case
  alias Asterix.PacketEncoder
  alias Asterix.PacketDecoder

  test "PacketEncoder encodes an empty string" do
    assert (PacketEncoder.string "") == <<0, 0>>
  end

  test "PacketEncoder encodes a non-empty string" do
    assert (PacketEncoder.string "hej") == <<0, 3, 104, 101, 106>>
  end

  test "PacketDecoder decodes an encoded string" do
    {s, rest} = PacketDecoder.decode_string(<<0, 3, 104, 101, 106>>)
    assert s == "hej"
    assert rest == <<>>
  end
end
