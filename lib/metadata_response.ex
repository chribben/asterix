defmodule Asterix.MetadataResponse do
  defstruct brokers: [], topics: []

  @type t :: %Asterix.MetadataResponse{
            # TODO: Use correct types here.
            brokers: list(any),
            topics: list(any)
        }
end

defimpl Asterix.Decodeable, for: Asterix.MetadataResponse do
  import Asterix.PacketDecoder
  alias Asterix.Decodeable
  alias Asterix.BrokerMetadata

  def decode(self, b) do
    {_size, b} = decode_int32(b)
    {broker_count, b} = decode_array_length(b)

    {brokers, b} = decode_into_array(
      &(Decodeable.decode %BrokerMetadata{}, &1),
      broker_count,
      b)

    {%{self | brokers: brokers}, b}
  end
end
