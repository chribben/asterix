defprotocol Asterix.Protocol.Decodeable do
  @spec decode(t, binary) :: {t, binary}
  def decode(self, b)
end
