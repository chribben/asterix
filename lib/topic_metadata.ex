defmodule Asterix.TopicMetadata do
  defstruct error_code: 0, name: "", partitions: []
end


defimpl Asterix.Decodeable, for: Asterix.TopicMetadata do
  import Asterix.PacketDecoder
  alias Asterix.PartitionMetadata

  def decode(self, b) do
    {error_code, b} = decode_int16(b)
    {name, b} = decode_string(b)

    {partitions, b} = decode_into_array(
      &(Decodeable.decode %PartitionMetadata{}, &1),
      b)

    {%{self |
       error_code: error_code,
       name: name,
       partitions: partitions}, b}
  end
end
