defmodule Asterix.Protocol.ProduceRequest.PartitionMessageSet do
  defstruct partition: 0, message_set: []
end

defimpl Asterix.Protocol.Encodeable, for: Asterix.Protocol.ProduceRequest.PartitionMessageSet do
  import Asterix.Protocol.Encoder
  alias Asterix.Protocol.Encodeable

  def encode(self) do
    msg_set = array(self.message_set, &Encodeable.encode/1)

    int32(self.partition) <>
    int32(byte_size(msg_set)) <>
    msg_set
  end
end

