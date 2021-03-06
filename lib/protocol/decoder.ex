defmodule Asterix.Protocol.Decoder do
  defp int_with_size(s, b) when is_binary(b) do
    <<n :: size(s), rest :: binary>> = b
    {n, rest}
  end
  def int16(b) do
    int_with_size(16, b)
  end

  def int32(b) do
    int_with_size(32, b)
  end

  def int64(b) do
    int_with_size(64, b)
  end

  def array_length(b) do
    int32(b)
  end

  def string(b) do
    {len, b} = int16(b)
    <<s :: size(len)-binary, b :: binary>> = b
    {s, b}
  end

  @spec into_array((binary -> {t, binary}),
                          binary) :: {list(t), binary} when t: any
  def into_array(f, b) do
    {len, b} = array_length(b)
    into_array(f, len, b)
  end

  @spec into_array((binary -> {t, binary}),
                        number,
                        binary) :: {list(t), binary} when t: any
  def into_array(_, 0, b) do
    {[], b}
  end
  def into_array(f, count, b) do
    {result, result_rest} = f.(b)
    {next, next_rest} = into_array(f, count - 1, result_rest)
    {[result | next], next_rest}
  end

  def int32_array(b) do
    into_array(&int32/1, b)
  end
end
