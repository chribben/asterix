defmodule AsterixTest do
  use ExUnit.Case
  alias Asterix.Encodeable
  alias Asterix.Decodeable
  alias Asterix.Request
  alias Asterix.MetadataRequest
  alias Asterix.MetadataResponse
  alias Asterix.BrokerMetadata
  alias Asterix.TopicMetadata

  def encode_metadata_request_with_topics(topics) do
    req = %Request{
            message: %MetadataRequest{topics: topics}}

    Encodeable.encode(req)
  end

  test "MetadataRequest with no topics encodes correctly" do
    data = encode_metadata_request_with_topics []

    expected =
    <<0, 0, 0, 21>> # size
    <> <<0, 3>> # api key for metadata request
    <> <<0, 0>> # api version
    <> <<0, 0, 0, 0>> # correlation id
    <> <<0, 7>> <> "asterix" # length and data for client id
    <> <<0, 0, 0, 0>> # array length

    assert data == expected
  end

  test "MetadataRequest with a single topic encodes correctly" do
    data = encode_metadata_request_with_topics ["hej"]
    expected =
    <<0, 0, 0, 26>> # size
    <> <<0, 3>> # api key for metadata request
    <> <<0, 0>> # api version
    <> <<0, 0, 0, 0>> # correlation id
    <> <<0, 7>> <> "asterix" # length and data for client id
    <> <<0, 0, 0, 1>> # array length
    <> <<0, 3, 104, 101, 106>> # length and data for "hej"

      assert data == expected
  end

  test "MetadataRequest with multiple topics encodes correctly" do
    data = encode_metadata_request_with_topics ["hej", "hopp"]
    expected =
    <<0, 0, 0, 32>> # size
    <> <<0, 3>> # api key for metadata request
    <> <<0, 0>> # api version
    <> <<0, 0, 0, 0>> # correlation id
    <> <<0, 7>> <> "asterix" # length and data for client id
    <> <<0, 0, 0, 2>> # array length
    <> <<0, 3, 104, 101, 106>> # length and data for "hej"
    <> <<0, 4, 104, 111, 112, 112>> # length and data for "hopp"

     assert data == expected
  end

  test "MetadataRequest with no brokers decodes correctly" do
    data =
    <<0, 0, 0, 8>> <> # response size
    <<0, 0, 0, 1>> <> # correlation id
    <<0, 0, 0, 0>> <> # broker array length
    <<0, 0, 0, 0>> #topic array length

    {response, _} = Decodeable.decode %MetadataResponse{}, data

    assert response.brokers == []
    assert response.topics == []
  end

  test "MetadataRequest with a single broker decodes correctly" do
    data =
    <<0, 0, 0, 8>> <> # response size
    <<0, 0, 0, 1>> <> # correlation id
    <<0, 0, 0, 1>> <> # broker array length
    <<0, 0, 0, 1>> <> # node id
    <<0, 9, "localhost">> <> # "localhost"
    <<0, 0, 35, 132>> <> # port 9092
    <<0, 0, 0, 0>> # topic array length

    {response, _} = Decodeable.decode %MetadataResponse{}, data

    assert response.brokers == [%BrokerMetadata{
                                        node_id: 1,
                                        host: "localhost",
                                        port: 9092 }]
    assert response.topics == []
  end

  test "MetadataRequest with a single topic decodes correctly" do
    data =
    <<0, 0, 0, 8>> <> # response size
    <<0, 0, 0, 1>> <> # correlation id
    <<0, 0, 0, 0>> <> # broker array length
    <<0, 0, 0, 1>> <> # topic array length
    <<0, 1>> <> # error code
    <<0, 4, "test">> <> # topic name
    <<0, 0, 0, 0>> # topic partition array length

      {response, _} = Decodeable.decode %MetadataResponse{}, data

    assert response.topics == [%TopicMetadata{
                                        error_code: 1,
                                        name: "test",
                                        partitions: [] }]
    assert response.brokers == []
  end

end
