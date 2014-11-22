defmodule ProduceRequestTest do
  use ExUnit.Case
  alias Asterix.Protocol.Encodeable
  alias Asterix.Protocol.Request
  alias Asterix.Protocol.ProduceRequest

  def encode_produce_request(pr) do
    req = %Request{message: pr}
    Encodeable.encode(req)
  end

  test "ProduceRequest with no topic partitions encodes correctly" do
    req = %ProduceRequest{required_acks: 0,
                          timeout: 1,
                          topic_partitions: []}
    data = encode_produce_request req

    expected =
    <<0, 0, 0, 27>> # size
    <> <<0, 3>> # api key for metadata request
    <> <<0, 0>> # api version
    <> <<0, 0, 0, 0>> # correlation id
    <> <<0, 7>> <> "asterix" # length and data for client id
    <> <<0, 0>> # RequiredAcks.no_response
    <> <<0, 0, 0, 1>> # timeout
    <> <<0, 0, 0, 0>> # topic_partitions array length

    assert data == expected
  end
end
