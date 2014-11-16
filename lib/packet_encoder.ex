defmodule Asterix.PacketEncoder do
  defstruct data: ""

  def prepend_binary(pe, b) do
    %{pe | data: b <> pe.data}
  end

  def prepend_int32(pe, n) do
    prepend_binary(pe, <<n :: size(32)>>)
  end

  def put_binary(pe, b) do
    %{pe | data: pe.data <> b}
  end

  def put_int16(pe, n) do
    put_binary(pe, <<n :: size(16)>>)
  end

  def put_int32(pe, n) do
    put_binary(pe, <<n :: size(32)>>)
  end

  def put_array_length(pe, len) do
    put_int32(pe, len)
  end

  def put_string(pe, s) do
    pe
    |> put_int16(byte_size s)
    |> put_binary(s)
  end

  def to_binary(pe) do
    pe.data
  end

  def data_byte_size(pe) do
    byte_size(pe.data)
  end
end
