defmodule Asterix.BrokerMetadata do
  defstruct test: 123
end

defimpl Asterix.Decodeable, for: Asterix.BrokerMetadata do

  def decode(self, b) do
    {self, b}
  end
end
