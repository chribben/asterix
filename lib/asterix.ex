defmodule Asterix do

  def connect(host, port) do
    :gen_tcp.connect host, port, [:binary, active: false]
  end

  def get_metadata(client, topics) do
    req = %Asterix.Request{
            message: %Asterix.MetadataRequest{topics: topics}}
    pe = %Asterix.PacketEncoder{}
    data = Asterix.Encodeable.encode(req, pe).to_binary

    :gen_tcp.send(client, data)
    :gen_tcp.recv(client, 0, 2000)
  end

end
