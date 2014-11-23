defmodule MessageSetEntryTest do
  use ExUnit.Case
  alias Asterix.Protocol.Message
  alias Asterix.Protocol.MessageSetEntry
  alias Asterix.Protocol.Encodeable

  test "MessageSetEntry encodes correctly" do
    message = %Message {
      crc: 0,
      attributes: Message.Compression.none,
      key: "important",
      value: "hi!"
    }
    msg_data = Encodeable.encode(message)

    entry = %MessageSetEntry { offset: 0, message: message }
    data = Encodeable.encode(entry)

    expected =
    <<0, 0, 0, 0, 0, 0, 0, 0>> # offset
    <> <<byte_size(msg_data) :: size(32)>> # message size
    <> msg_data

    assert data == expected
  end
end
