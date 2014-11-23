defmodule Asterix.Protocol.ProduceRequest.TopicPartition do
  defstruct topic_name: "", partition_message_sets: []
end

defimpl Asterix.Protocol.Encodeable, for: Asterix.Protocol.ProduceRequest.TopicPartition do
  import Asterix.Protocol.Encoder
  alias Asterix.Protocol.Encodeable

  def encode(self) do
    string(self.topic_name) <>
    array(self.partition_message_sets, &Encodeable.encode/1)
  end
end
