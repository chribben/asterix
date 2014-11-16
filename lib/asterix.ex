defmodule Asterix do

  def connect(host, port) do
    :gen_tcp.connect host, port, [:binary, active: false]
  end

  def get_metadata(client, topics) do
    req = %Asterix.Request{
            message: %Asterix.MetadataRequest{topics: topics}}

    data = Asterix.Encodeable.encode(req)

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
