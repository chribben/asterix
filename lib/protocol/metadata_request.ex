defmodule Asterix.Protocol.MetadataRequest do
  defstruct topics: [], api_key: 3
end

defimpl Asterix.Protocol.Encodeable, for: Asterix.Protocol.MetadataRequest do
  import Asterix.Protocol.Encoder

  def encode(self) do
    array self.topics, &string/1
  end
end
