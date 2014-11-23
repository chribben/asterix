defmodule TopicPartitionTest do
  use ExUnit.Case
  alias Asterix.Protocol.Encodeable
  alias Asterix.Protocol.ProduceRequest.TopicPartition
  alias Asterix.Protocol.ProduceRequest.PartitionMessageSet

  test "TopicPartition with no partition message sets encodes correctly" do
    topic_partition = %TopicPartition{
      topic_name: "test",
      partition_message_sets: []
    }
    data = Encodeable.encode topic_partition

    expected =
    <<0, 4>> <> "test" # length and data for topic name
    <> <<0, 0, 0, 0>> # partition message sets array length

    assert data == expected
  end

  test "TopicPartition with a partition message set encodes correctly" do
    empty_set = %PartitionMessageSet{
      partition: 1,
      message_set_size: 4, # 4 bytes for the array length
      message_set: []
    }
    topic_partition = %TopicPartition{
      topic_name: "test",
      partition_message_sets: [empty_set]
    }
    data = Encodeable.encode topic_partition

    expected =
    <<0, 4>> <> "test" # length and data for topic name
    <> <<0, 0, 0, 1>> # partition message sets array length
    <> <<0, 0, 0, 1>> # partition
    <> <<0, 0, 0, 4>> # message set byte size
    <> <<0, 0, 0, 0>> # message set array length

    assert data == expected
  end
end
