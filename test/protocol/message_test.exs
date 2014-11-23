defmodule MessageTest do
  use ExUnit.Case
  alias Asterix.Protocol.Message
  alias Asterix.Protocol.Encodeable

  test "Message encodes correctly" do
    message = %Message {
      crc: 0,
      attributes: Message.Compression.none,
      key: "important",
      value: "hi!"
    }
    data = Encodeable.encode(message)
    expected =
    <<0, 0, 0, 0>> # crc
    <> <<0>> # magic byte
    <> <<0>> # attributes (Compression.none)
    <> <<0, 0, 0, 9>> <> message.key # length and data for key
    <> <<0, 0, 0, 3>> <> message.value # length and data for value

    assert data == expected
  end
end
