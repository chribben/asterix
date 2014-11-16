defmodule Asterix.MetadataRequest do
  defstruct topics: [], api_key: 3

  def put_strings(pe, []), do: pe
  def put_strings(pe, [head|tail]) do
    pe
    |> Asterix.PacketEncoder.put_string(head)
    |> put_strings(tail)
  end
end

defimpl Asterix.Encodeable, for: Asterix.MetadataRequest do
  def encode(self, pe) do
    pe
    |> Asterix.PacketEncoder.put_array_length(length(self.topics))
    |> Asterix.MetadataRequest.put_strings self.topics
  end
end
