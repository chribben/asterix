defmodule Asterix.PacketDecoder do
  def read_int32(b) do
    <<n :: size(32), rest :: binary>> = b
    {n, rest}
  end

  def read_array_length(b) do
    read_int32(b)
  end

  @spec read_into_array((binary -> {t, binary}),
                        number,
                        binary) :: {list(t), binary} when t: any
  def read_into_array(_, 0, b) do
    {[], b}
  end
  def read_into_array(f, len, b) do
    {result, result_rest} = f.(b)
    {next, next_rest} = read_into_array(f, len - 1, result_rest)
    {[result | next], next_rest}
  end
end
