defmodule DNA do
  def encode_nucleotide(code_point) do
    cond do
      code_point == ?\s  -> 0
      code_point == ?A -> 1
      code_point == ?C -> 2
      code_point == ?G -> 4
      code_point == ?T -> 8
    end
  end

  def decode_nucleotide(encoded_code) do
    cond do
      encoded_code == 0 -> ?\s
      encoded_code == 1 -> ?A
      encoded_code == 2 -> ?C
      encoded_code == 4 -> ?G
      encoded_code == 8 -> ?T
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  def decode(dna) do
    do_decode(dna, ~c"")
  end

  defp do_encode([], bitstr), do: bitstr
  defp do_encode([head | tail], bitsr) do
    do_encode(tail, <<bitsr::bitstring, encode_nucleotide(head)::size(4)>>)
  end

  defp do_decode(<<>>, str), do: str
  defp do_decode(<<head::size(4), tail::bitstring>>, str) do
    do_decode(tail, str ++ [decode_nucleotide(head)])
  end
end
