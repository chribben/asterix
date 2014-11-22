defmodule Asterix.Protocol.MetadataResponse do
  defstruct correlation_id: 0, brokers: [], topics: []

  @type t :: %Asterix.Protocol.MetadataResponse{
            # TODO: Use correct types here.
            brokers: list(any),
            topics: list(any)
        }
end

defimpl Asterix.Protocol.Decodeable, for: Asterix.Protocol.MetadataResponse do
  import Asterix.Protocol.Decoder
  alias Asterix.Protocol.Decodeable
  alias Asterix.Protocol.BrokerMetadata
  alias Asterix.Protocol.TopicMetadata

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
