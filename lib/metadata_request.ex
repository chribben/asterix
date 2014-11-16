defmodule Asterix.MetadataRequest do
  defstruct topics: [], api_key: 3
end

defimpl Asterix.Encodeable, for: Asterix.MetadataRequest do
  import Asterix.PacketEncoder

  def encode(self) do
    array_length(length(self.topics)) <> strings self.topics
  end
end
