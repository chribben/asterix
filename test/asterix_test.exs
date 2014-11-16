defmodule AsterixTest do
  use ExUnit.Case

  test "MetadataRequest encodes correctly" do
    topics = ["hej", "hopp"]
    req = %Asterix.Request{
            message: %Asterix.MetadataRequest{topics: topics}}
    pe = %Asterix.PacketEncoder{}

    data = Asterix.PacketEncoder.to_binary(
      Asterix.Encodeable.encode(req, pe))

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
end
