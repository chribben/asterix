defmodule PartitionMetadataDecodeTest do
  use ExUnit.Case
  alias Asterix.Decodeable
  alias Asterix.PartitionMetadata

  test "PartitionMetadata with error replica decodes properly" do
    data =
    <<0, 9>> <> # error code
    <<0, 0, 0, 0>> <> # id
    <<0, 0, 0, 0>> <> # leader
    <<0, 0, 0, 0>> <> # replicas array length
    <<0, 0, 0, 0>> # isr array length

      {pm, b} = Decodeable.decode %PartitionMetadata{}, data

    assert pm == %PartitionMetadata{error_code: 9,
                                    id: 0,
                                    leader: 0,
                                    replicas: [],
                                    isr: []}
    assert b == <<>>
  end

  test "PartitionMetadata with one leader and one replica decodes properly" do
    data =
    <<0, 9>> <> # error code
    <<0, 0, 0, 1>> <> # id
    <<0, 0, 0, 2>> <> # leader
    <<0, 0, 0, 1>> <> # replicas array length
    <<0, 0, 0, 1>> <> # replica #1
    <<0, 0, 0, 1>> <> # isr array length
    <<0, 0, 0, 1>> # #1 is caught up to master

      {pm, b} = Decodeable.decode %PartitionMetadata{}, data

    assert pm == %PartitionMetadata{error_code: 9,
                                    id: 1,
                                    leader: 2,
                                    replicas: [1],
                                    isr: [1]}
    assert b == <<>>
  end
end
