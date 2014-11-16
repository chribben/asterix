defmodule Asterix.PacketEncoder do
  def int16(n) do
    <<n :: size(16)>>
  end

  def int32(n) do
    <<n :: size(32)>>
  end

  def array_length(len) do
    int32(len)
  end

  def string(s) do
    int16(byte_size s) <> <<s :: binary>>
  end

  def strings([]) do
    ""
  end

  def strings([head|tail]) do
    Asterix.PacketEncoder.string(head) <> strings(tail)
  end
end
