defmodule Asterix do
  alias Asterix.Request
  alias Asterix.MetadataRequest
  alias Asterix.Encodeable

  def connect(host, port) do
    :gen_tcp.connect host, port, [:binary, active: false]
  end

  def get_metadata(client, topics) do
    req = %Request{
            message: %MetadataRequest{topics: topics}}

    data = Encodeable.encode(req)

    :gen_tcp.send(client, data)
    :gen_tcp.recv(client, 0, 2000)
  end

  def main do
    {:ok, client} = connect :localhost, 9092
    {:ok, res} = get_metadata client, ["test"]
    IO.puts "Response:"
    IO.inspect res
  end

end
