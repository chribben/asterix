defmodule Asterix do
  alias Asterix.Request
  alias Asterix.MetadataRequest
  alias Asterix.MetadataResponse
  alias Asterix.Encodeable
  alias Asterix.Decodeable

  def connect(host, port) do
    :gen_tcp.connect host, port, [:binary, active: false]
  end

  def get_response(client) do
    # First 4 bytes is the response size
    {:ok, size_data} = :gen_tcp.recv(client, 4, 2000)
    size = Integer.parse(size_data)
    :gen_tcp.recv(client, size, 2000)
  end

  def get_metadata(client, topics) do
    req = %Request{
            message: %MetadataRequest{topics: topics}}

    request_data = Encodeable.encode(req)

    :gen_tcp.send(client, request_data)
    {:ok, response_data} = get_response(client)

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
