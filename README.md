# Asterix

A work-in-progress Kafka client library written in Elixir.

## Status

Asterix will start out as a simple client to the
[Kafka APIs](https://cwiki.apache.org/confluence/display/KAFKA/A+Guide+To+The+Kafka+Protocol)
without any further features. When it is stable enough it could become a more
capable client that handles the low level details for you automatically (batching,
broker tracking, etc), using the aforementioned APIs. These following tasks are
just for the initial scope.

### Done

* Metadata API

### Not Done

* Produce API *(in progress)*
* Fetch API
* Offset API
* (Offset Commit/Fetch API)

## Running

Given that you have a Kafka server running at `locahost:9092`, run:

```bash
mix run -e 'Asterix.main :localhost, 9092'
```

Currently that only displays the structure of a MetadataResponse from
Kafka.

## Tests

```bash
mix test
```

## License

Asterix source code is released under the MIT License, see [LICENSE](LICENSE)
for more information.
