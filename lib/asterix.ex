defmodule Asterix do
  alias Asterix.Request
  alias Asterix.MetadataRequest
  alias Asterix.MetadataResponse
  alias Asterix.Encodeable
  alias Asterix.Decodeable
  alias Asterix.PacketDecoder

  @default_timeout 2000

  def connect(host, port) do
    :gen_tcp.connect host, port, [:binary, active: false]
  end

  defp encode_and_send_request(client, struct) do
    req = %Request{message: struct}
    data = Encodeable.encode req
    :gen_tcp.send client, data
  end

  defp get_response(client) do
    # First 4 bytes is the response size
    case :gen_tcp.recv client, 4, @default_timeout do
      {:ok, data} ->
        {size, _} = PacketDecoder.decode_int32(data)
        :gen_tcp.recv client, size, @default_timeout
      e -> e
    end
  end

  defp get_response_and_decode(client, struct) do
    case get_response client do
      {:ok, data} ->
        {res, _} = Decodeable.decode struct, data
        {:ok, res}
      e -> e
    end
  end

  defp send_request_and_get_response(client, req, res) do
    case encode_and_send_request client, req do
      :ok -> get_response_and_decode client, res
      e -> e
    end
  end

  def get_metadata(client, topics) do
    req = %MetadataRequest{topics: topics}
    send_request_and_get_response client, req, %MetadataResponse{}
  end

  def main do
    main :localhost, 9092
  end

  def main(host, port) do
    case connect host, port do
      {:ok, client} ->
        case get_metadata client, ["test"] do
          {:ok, metadata} ->
            IO.puts "Metadata:"
            IO.inspect metadata
          {:error, e} ->
            IO.puts :stderr, e
        end
      {:error, e} ->
        IO.puts :stderr, "Failed to connect to Kafka: #{e}"
    end
  end

end
