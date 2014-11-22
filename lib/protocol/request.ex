defmodule Asterix.Protocol.Request do
  defstruct api_version: 0,
  correlation_id: 0,
  client_id: "asterix",
  message: nil
end

defimpl Asterix.Protocol.Encodeable, for: Asterix.Protocol.Request do
  import Asterix.Protocol.Encoder
  alias Asterix.Protocol.Encodeable

  def encode(self) do
    msg = int16(self.message.api_key) <>
      int16(self.api_version) <>
      int32(self.correlation_id) <>
      string(self.client_id) <>
      Encodeable.encode(self.message)

    int32(byte_size(msg)) <> msg
  end
end
