defmodule Asterix.MetadataResponse do
  defstruct correlation_id: 0, brokers: [], topics: []

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
  alias Asterix.TopicMetadata

  def decode(self, b) do
    {brokers, b} = decode_into_array(
      &(Decodeable.decode %BrokerMetadata{}, &1),
      b)

    {topics, b} = decode_into_array(
      &(Decodeable.decode %TopicMetadata{}, &1),
      b)

    {%{self |
       brokers: brokers,
       topics: topics}, b}
  end
end
