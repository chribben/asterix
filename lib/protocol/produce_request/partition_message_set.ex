defmodule Asterix.Protocol.ProduceRequest.PartitionMessageSet do
  defstruct partition: 0, message_set_size: 0, message_set: nil
end

defimpl Asterix.Protocol.Encodeable, for: Asterix.Protocol.ProduceRequest.PartitionMessageSet do
  import Asterix.Protocol.Encoder
  alias Asterix.Protocol.Encodeable

  def encode(self) do
    int32(self.partition) <>
    int32(self.message_set_size) <>
    array(self.message_set, &Encodeable.encode/1)
  end
end

