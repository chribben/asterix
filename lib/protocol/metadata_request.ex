defmodule Asterix.Protocol.MetadataRequest do
  defstruct topics: [], api_key: 3
end

defimpl Asterix.Protocol.Encodeable, for: Asterix.Protocol.MetadataRequest do
  import Asterix.Protocol.PacketEncoder

  def encode(self) do
    array_length(length(self.topics)) <> strings self.topics
  end
end
