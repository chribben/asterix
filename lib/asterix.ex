defmodule Asterix do
  alias Asterix.Protocol.Request
  alias Asterix.Protocol.Response
  alias Asterix.Protocol.MetadataRequest
  alias Asterix.Protocol.MetadataResponse
  alias Asterix.Protocol.Encodeable
  alias Asterix.Protocol.Decodeable
  alias Asterix.Protocol.Decoder
  alias Asterix.Protocol.ProduceRequest
  alias Asterix.Protocol.ProduceRequest.TopicPartition
  alias Asterix.Protocol.ProduceRequest.PartitionMessageSet
  alias Asterix.Protocol.MessageSetEntry
  alias Asterix.Protocol.Message

  @default_timeout 2000

  def connect(host, port) do
    :gen_tcp.connect host, port, [:binary, active: false]
  end

  defp encode_and_send_request(client, req) do
    data = Encodeable.encode req
    :gen_tcp.send client, data
  end

  defp get_response(client) do
    # First 4 bytes is the response size
    case :gen_tcp.recv client, 4, @default_timeout do
      {:ok, data} ->
        {size, _} = Decoder.int32(data)
        :gen_tcp.recv client, size, @default_timeout
      e -> e
    end
  end

  defp get_response_and_decode(client, res) do
    case get_response client do
      {:ok, data} ->
        {res, _} = Decodeable.decode res, data
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
    req = %Request{message: %MetadataRequest{topics: topics},
                   correlation_id: 1}
    res = %Response{message: %MetadataResponse{}}
    case send_request_and_get_response client, req, res do
      {:ok, metadata} ->
        IO.puts "Result"
        IO.inspect metadata
        :ok
      e -> e
    end
  end

  def produce(client, topic) do
    message = %Message {
      value: "something else entirely"
    }
    message_set = [
      %MessageSetEntry {
        offset: 0,
        message: message
      }
    ]
    partition_message_sets = [
      %PartitionMessageSet {
        partition: 0,
        message_set: message_set
      }
    ]
    topic_partitions = [
      %TopicPartition {
        topic_name: topic,
        partition_message_sets: partition_message_sets
      }
    ]
    produce_request = %ProduceRequest {
      timeout: 100,
      topic_partitions: topic_partitions
    }
    req = %Request { message: produce_request }

    case encode_and_send_request(client, req) do
      :ok ->
        IO.inspect(get_response client)
        IO.puts("Sent!")
        :ok
      e -> e
    end
  end

  def main do
    main :localhost, 9092, :metadata
  end

  def main(host, port, action) do
    case connect host, port do
      {:ok, client} ->
        result = case action do
          :metadata -> get_metadata client, ["test"]
          :produce -> produce client, "test"
        end
        case result do
          {:error, e} ->
            IO.puts :stderr, e
          _  -> IO.puts "Exiting..."
        end
      {:error, e} ->
        IO.puts :stderr, "Failed to connect to Kafka: #{e}"
    end
  end

end
