# Asterix

A (currently useless) Kafka client library written in Elixir.

## Running

Given that you have a Kafka server running at `locahost:9092`, run:

```bash
iex -S mix
```

And then in `iex`:
```
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.0.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> Asterix.main
Response:
<<0, 0, 0, 155, ...>>
```

## Tests

```bash
mix test
```
