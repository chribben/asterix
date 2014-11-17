defmodule Asterix.PartitionMetadata do
  defstruct error_code: 0, id: 0, leader: 0, replicas: [], isr: 0
end

defimpl Asterix.Decodeable, for: Asterix.PartitionMetadata do
  import Asterix.PacketDecoder

  def decode(self, b) do
    {error_code, b} = decode_int16(b)
    {id, b} = decode_int32(b)
    {leader, b} = decode_int32(b)

    {replicas, b} = decode_into_array(
      &(decode_int32 &1),
      b)

    {isr, b} = decode_into_array(
      &(decode_int32 &1),
      b)

    {%{self |
       error_code: error_code,
       id: id,
       leader: leader,
       replicas: replicas,
       isr: isr}, b}
  end
end
