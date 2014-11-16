defmodule Asterix.Request do
  defstruct api_version: 0,
  correlation_id: 0,
  client_id: "asterix",
  message: nil
end


defimpl Asterix.Encodeable, for: Asterix.Request do
  def encode(self, pe) do
    with_keys = pe
    |> Asterix.PacketEncoder.put_int16(self.message.api_key)
    |> Asterix.PacketEncoder.put_int16(self.api_version)
    |> Asterix.PacketEncoder.put_int32(self.correlation_id)
    |> Asterix.PacketEncoder.put_string(self.client_id)

    with_msg = Asterix.Encodeable.encode(self.message, with_keys)

    size = Asterix.PacketEncoder.data_byte_size(with_msg)
    Asterix.PacketEncoder.prepend_int32(with_msg, size)
  end
end
