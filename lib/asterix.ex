defmodule Asterix do

  # RequestMessage => ApiKey ApiVersion CorrelationId ClientId RequestMessage
  #   ApiKey => int16
  #   ApiVersion => int16
  #   CorrelationId => int32
  #   ClientId => string
  #   RequestMessage => MetadataRequest | ProduceRequest | FetchRequest
  #                   | OffsetRequest | OffsetCommitRequest | OffsetFetchRequest
  defmodule Request do
    defstruct api_key: nil, api_version: 0, correlation_id: 0,
    client_id: nil, request_message: nil
  end

  # MetadataRequest => [TopicName]
  #   TopicName => string
  defmodule MetadataRequest do
    defstruct topic_names: []
  end


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
  defmodule MetadataResponse do
    defstruct brokers: [], topics_metadata: []

    defmodule Broker do
      defstruct node_id: nil, host: nil, port: nil
    end

    defmodule TopicMetadata do
      defstruct topic_error_code: nil, topic_name: nil,
      partions_metadata: []
    end

    defmodule PartitionMetadata do
      defstruct partition_error_code: nil, partition_id: nil, leader:
      nil, replicas: [], isr: []
    end
  end
end
