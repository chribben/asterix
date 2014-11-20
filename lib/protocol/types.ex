defmodule Asterix.Protocol.Types do

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
  @type metadata_response :: {list(broker), list(topic_metadata)}
  @type broker :: {node_id, broker_host, broker_port}
  @type node_id :: integer
  @type broker_host :: char_list
  @type broker_port :: integer
  @type topic_metadata :: {topic_error_code, topic_name,
                           list(partition_metadata)}
  @type topic_error_code :: integer
  @type partition_metadata :: {partition_error_code, partition_id, leader,
                              replicas, isr}
  @type partition_error_code :: integer
  @type partition_id :: integer
  @type leader :: integer
  @type replicas :: list(integer)
  @type isr :: list(integer)

  # Message => Crc MagicByte Attributes Key Value
  #   Crc => int32
  #   MagicByte => int8
  #   Attributes => int8
  #   Key => bytes
  #   Value => bytes
  @type message :: {crc, magic_byte, attributes, key, value}
  @type crc :: integer
  @type magic_byte :: integer
  @type attributes :: integer
  @type key :: binary
  @type value :: binary

  # MessageSet => [Offset MessageSize Message]
  #   Offset => int64
  #   MessageSize => int32
  @type message_set :: list({offset, message_size, message})
  @type offset :: integer
  @type message_size :: integer

  # ProduceRequest => RequiredAcks Timeout [TopicName [Partition MessageSetSize MessageSet]]
  #   RequiredAcks => int16
  #   Timeout => int32
  #   Partition => int32
  #   MessageSetSize => int32
  @type produce_request :: {required_acks, produce_timeout,
                            list({topic_name, list({partition,
                                                    message_set_size,
                                                    message_set})})}
  @type required_acks :: integer
  @type produce_timeout :: integer
  @type partition :: integer
  @type message_set_size :: integer

  # MetadataRequest => [TopicName]
  #   TopicName => string
  @type metadata_request :: list(topic_name)
  @type topic_name :: char_list

  # RequestMessage => ApiKey ApiVersion CorrelationId ClientId RequestMessage
  #   ApiKey => int16
  #   ApiVersion => int16
  #   CorrelationId => int32
  #   ClientId => string
  #   RequestMessage => MetadataRequest | ProduceRequest | FetchRequest
  #                   | OffsetRequest | OffsetCommitRequest | OffsetFetchRequest
  @type request :: {api_key, api_version, correlation_id, client_id, request_message}
  @type api_key :: integer
  @type api_version :: integer
  @type correlation_id :: integer
  @type client_id :: char_list
  @type request_message :: metadata_request # | ...

  # TODO: moar typez

end
