defmodule Asterix.Request do
  defstruct api_key: 0,
  api_version: 0,
  correlation_id: 0,
  client_id: "",
  message: nil
end


defimpl Asterix.Encodeable, for: Asterix.Request do
  def encode(self, pe) do
    with_keys = pe
    |> Asterix.PacketEncoder.put_int16(self.api_key)
    |> Asterix.PacketEncoder.put_int16(self.api_version)
    |> Asterix.PacketEncoder.put_int32(self.correlation_id)
    |> Asterix.PacketEncoder.put_string(self.client_id)

    Asterix.Encodeable.encode(self.message, with_keys)
  end
end
