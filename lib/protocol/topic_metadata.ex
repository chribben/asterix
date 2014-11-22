defmodule Asterix.Protocol.TopicMetadata do
  defstruct error_code: 0, name: "", partitions: []
end


defimpl Asterix.Protocol.Decodeable, for: Asterix.Protocol.TopicMetadata do
  import Asterix.Protocol.Decoder
  alias Asterix.Protocol.Decodeable
  alias Asterix.Protocol.PartitionMetadata

  def decode(self, b) do
    {error_code, b} = int16(b)
    {name, b} = string(b)

    {partitions, b} = into_array(
      &(Decodeable.decode %PartitionMetadata{}, &1),
      b)

    {%{self |
       error_code: error_code,
       name: name,
       partitions: partitions}, b}
  end
end
