# Asterix

A work-in-progress Kafka client library written in Elixir.

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
