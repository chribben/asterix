defmodule Asterix do
  alias Asterix.Request
  alias Asterix.MetadataRequest
  alias Asterix.MetadataResponse
  alias Asterix.Encodeable
  alias Asterix.Decodeable

  def connect(host, port) do
    :gen_tcp.connect host, port, [:binary, active: false]
  end

  def get_metadata(client, topics) do
    req = %Request{
            message: %MetadataRequest{topics: topics}}

    request_data = Encodeable.encode(req)

    :gen_tcp.send(client, request_data)
    {:ok, response_data} = :gen_tcp.recv(client, 0, 2000)

    {res, _b} = Decodeable.decode(%MetadataResponse{}, response_data)
    res
  end

  def main do
    {:ok, client} = connect :localhost, 9092
    res = get_metadata client, ["test"]
    IO.puts "Response:"
    IO.inspect res
  end

end
