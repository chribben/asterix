defmodule Asterix.Protocol.PartitionMetadata do
  defstruct error_code: 0, id: 0, leader: 0, replicas: [], isr: []
end

defimpl Asterix.Protocol.Decodeable, for: Asterix.Protocol.PartitionMetadata do
  import Asterix.Protocol.PacketDecoder

  def decode(self, b) do
    {error_code, b} = decode_int16(b)
    {id, b} = decode_int32(b)
    {leader, b} = decode_int32(b)

    {replicas, b} = decode_int32_array(b)
    {isr, b} = decode_int32_array(b)

    {%{self |
       error_code: error_code,
       id: id,
       leader: leader,
       replicas: replicas,
       isr: isr}, b}
  end
end
