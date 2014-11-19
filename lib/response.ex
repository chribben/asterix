defmodule Asterix.Response do
  defstruct correlation_id: 0, message: nil

  @type t :: %Asterix.Response{
            correlation_id: number,
            message: any
        }
end

defimpl Asterix.Decodeable, for: Asterix.Response do
  import Asterix.PacketDecoder
  alias Asterix.Decodeable

  def decode(self, b) do
    {correlation_id, b} = decode_int32(b)
    {message, b} = Decodeable.decode(self.message, b)
    {%{self |
       correlation_id: correlation_id,
       message: message}, b}
  end
end
