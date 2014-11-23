defmodule Asterix.Protocol.MessageSetEntry do
  defstruct offset: 0, message_size: 0, message: nil
end

defimpl Asterix.Protocol.Encodeable, for: Asterix.Protocol.MessageSetEntry do
  import Asterix.Protocol.Encoder
  alias Asterix.Protocol.Encodeable

  def encode(self) do
    int64(self.offset) <>
    int32(self.message_size) <>
    Encodeable.encode(self.message)
  end
end

defimpl Asterix.Protocol.Decodeable, for: Asterix.Protocol.MessageSetEntry do
  import Asterix.Protocol.Decoder
  alias Asterix.Protocol.Decodeable

  def decode(self, b) do
    { offset, b } = int64(self.offset)
    { message_size, b } = int32(self.message_size)
    { message, b } = Decodeable.decode(self.message, b)
    decoded = %{ self |
      offset: offset,
      message_size: message_size,
      message: message
    }

    { decoded, b }
  end
end
