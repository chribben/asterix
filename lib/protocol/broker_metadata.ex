defmodule Asterix.Protocol.BrokerMetadata do
  defstruct node_id: 0, host: "", port: 0
end

defimpl Asterix.Protocol.Decodeable, for: Asterix.Protocol.BrokerMetadata do
  import Asterix.Protocol.PacketDecoder

  def decode(self, b) do
    {node_id, b} = decode_int32(b)
    {host, b} = decode_string(b)
    {port, b} = decode_int32(b)
    {%{self | node_id: node_id, host: host, port: port}, b}
  end
end
