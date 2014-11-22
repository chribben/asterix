defmodule Asterix.Protocol.ProduceRequest do
  defmodule RequiredAcks do
    def no_response, do: 0
    def wait_for_local, do: 1
    def wait_for_all, do: -1
  end

  defstruct required_acks: 0, timeout: 0, topic_partitions: [], api_key: 3
end

defimpl Asterix.Protocol.Encodeable, for: Asterix.Protocol.ProduceRequest do
  import Asterix.Protocol.Encoder
  alias Asterix.Protocol.Encodeable

  def encode(self) do
    int16(self.required_acks) <>
    int32(self.timeout) <>
    array(self.topic_partitions, &Encodeable.encode/1)
  end
end
