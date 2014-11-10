defmodule Asterix do

  # RequestMessage => ApiKey ApiVersion CorrelationId ClientId RequestMessage
  #   ApiKey => int16
  #   ApiVersion => int16
  #   CorrelationId => int32
  #   ClientId => string
  #   RequestMessage => MetadataRequest | ProduceRequest | FetchRequest
  #                   | OffsetRequest | OffsetCommitRequest | OffsetFetchRequest
  @type Request :: {ApiKey, ApiVersion, CorrelationId, ClientId, RequestMessage}
  @type ApiKey :: Integer
  @type ApiVersion :: Integer
  @type CorrelationId :: Integer
  @type ClientId :: char_list
  @type RequestMessage :: MetadataRequest | ProduceRequest |
  FetchRequest | OffsetRequest | OffsetCommitRequest | OffsetFetchRequest

  # MetadataRequest => [TopicName]
  #   TopicName => string
  @type MetadataRequest :: list(TopicName)
  @type TopicName :: char_list

  # MetadataResponse => [Broker][TopicMetadata]
  #   Broker => NodeId Host Port
  #   NodeId => int32
  #   Host => string
  #   Port => int32
  #   TopicMetadata => TopicErrorCode TopicName [PartitionMetadata]
  #   TopicErrorCode => int16
  #   PartitionMetadata => PartitionErrorCode PartitionId Leader Replicas Isr
  #   PartitionErrorCode => int16
  #   PartitionId => int32
  #   Leader => int32
  #   Replicas => [int32]
  #   Isr => [int32]
  @type MetadataResponse :: {list(Broker), list(TopicMetadata)}
  @type Broker :: {NodeId, Host, Port}
  @type NodeId :: Integer
  @type Host :: char_list
  @type Port :: Integer
  @type TopicMetadata :: {TopicErrorCode, TopicName, list(PartitionMetadata)}
  @type PartitionErrorCode :: Integer
  @type PartitionId :: Integer
  @type Leader :: Integer
  @type Replicas :: list(Integer)
  @type Isr :: list(Integer)

  # MessageSet => [Offset MessageSize Message]
  #   Offset => int64
  #   MessageSize => int32
  @type MessageSet :: list({Offset, MessageSize, Message})
  @type Offset :: Integer
  @type MessageSize :: Integer

  # Message => Crc MagicByte Attributes Key Value
  #   Crc => int32
  #   MagicByte => int8
  #   Attributes => int8
  #   Key => bytes
  #   Value => bytes
  @type Message :: {Crc, MagicByte, Attributes, Key, Value}
  @type Crc :: Integer
  @type MagicByte :: Integer
  @type Attributes :: Integer
  @type Key :: binary
  @type Value :: binary

  # ProduceRequest => RequiredAcks Timeout [TopicName [Partition MessageSetSize MessageSet]]
  #   RequiredAcks => int16
  #   Timeout => int32
  #   Partition => int32
  #   MessageSetSize => int32
  @type ProduceRequest :: {RequiredAcks, Timeout,
                           list({TopicName, list({Partition,
                                                  MessageSetSize,
                                                  MessageSet})})}
  @type RequiredAcks :: Integer
  @type Timeout :: Integer
  @type Partition :: Integer
  @type MessageSetSize :: Integer


  # TODO: MOOOAAAR TYPEZZZZZZ

end
