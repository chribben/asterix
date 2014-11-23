defmodule Asterix.Protocol.Encoder do
  def int16(n) when is_number(n) do
    <<n :: size(16)>>
  end

  def int32(n) when is_number(n) do
    <<n :: size(32)>>
  end

  def int64(n) when is_number(n) do
    <<n :: size(64)>>
  end

  def string(s) do
    int16(byte_size s) <> <<s :: binary>>
  end

  def strings([]) do
    ""
  end

  def strings([head|tail]) do
    string(head) <> strings(tail)
  end

  defp array_length(len) when is_number(len) do
    int32(len)
  end
  defp array_length(x) when is_list(x) do
    array_length(length(x))
  end

  defp array_elements([], _) do
    ""
  end
  defp array_elements([head|tail], f) do
    f.(head) <> array_elements(tail, f)
  end

  def array(l, f) do
    array_length(l) <>
    array_elements(l, f)
  end
end
