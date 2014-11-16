defmodule Asterix.MetadataRequest do
  defstruct topics: [], api_key: 3
end

defimpl Asterix.Encodeable, for: Asterix.MetadataRequest do
  def encode(self) do
    Asterix.PacketEncoder.array_length(length(self.topics)) <>
      Asterix.PacketEncoder.strings self.topics
  end
end
