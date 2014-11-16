defmodule Asterix.Request do
  defstruct api_version: 0,
  correlation_id: 0,
  client_id: "asterix",
  message: nil
end


defimpl Asterix.Encodeable, for: Asterix.Request do
  def encode(self) do
    msg = Asterix.PacketEncoder.int16(self.message.api_key) <>
      Asterix.PacketEncoder.int16(self.api_version) <>
      Asterix.PacketEncoder.int32(self.correlation_id) <>
      Asterix.PacketEncoder.string(self.client_id) <>
      Asterix.Encodeable.encode(self.message)

    Asterix.PacketEncoder.int32(byte_size(msg)) <> msg
  end
end
