defmodule Asterix.Protocol.Response do
  defstruct correlation_id: 0, message: nil

  @type t :: %Asterix.Protocol.Response{
            correlation_id: number,
            message: any
        }
end

defimpl Asterix.Protocol.Decodeable, for: Asterix.Protocol.Response do
  import Asterix.Protocol.Decoder
  alias Asterix.Protocol.Decodeable

  def decode(self, b) do
    {correlation_id, b} = decode_int32(b)
    {message, b} = Decodeable.decode(self.message, b)
    {%{self |
       correlation_id: correlation_id,
       message: message}, b}
  end
end
