defmodule Asterix.PacketDecoder do
  def decode_int16(b) do
    <<n :: size(16), rest :: binary>> = b
    {n, rest}
  end

  def decode_int32(b) do
    <<n :: size(32), rest :: binary>> = b
    {n, rest}
  end

  def decode_array_length(b) do
    decode_int32(b)
  end

  def decode_string(b) do
    {len, b} = decode_int16(b)
    <<s :: size(len)-binary, b :: binary>> = b
    {s, b}
  end

  @spec decode_into_array((binary -> {t, binary}),
                        number,
                        binary) :: {list(t), binary} when t: any
  def decode_into_array(_, 0, b) do
    {[], b}
  end
  def decode_into_array(f, count, b) do
    {result, result_rest} = f.(b)
    {next, next_rest} = decode_into_array(f, count - 1, result_rest)
    {[result | next], next_rest}
  end
end
