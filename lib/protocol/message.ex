defmodule Asterix.Protocol.Message do
  defstruct crc: 0, magic_byte: 0, attributes: 0, key: nil, value: nil

  defmodule Compression do
    def none, do: 0
    def gzip, do: 1
    def snappy, do: 2
  end
end

defimpl Asterix.Protocol.Encodeable, for: Asterix.Protocol.Message do
  import Asterix.Protocol.Encoder

  def encode(self) do
    key = case self.key do
      nil -> <<>>
      b -> bytes(b)
    end

    int32(self.crc) <>
    int8(self.magic_byte) <>
    int8(self.attributes) <>
    key <>
    bytes(self.value)
  end
end
