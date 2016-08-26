defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2), do: {:error, "Lists must be the same length."}
  def hamming_distance(strand1, strand2), do: {:ok, calc_hamming_distance(strand1, strand2, 0)}

  defp calc_hamming_distance([nucleotide1 | strand1], [nucleotide2 | strand2], dist) when nucleotide1 != nucleotide2,
    do: calc_hamming_distance(strand1, strand2, dist + 1)
  defp calc_hamming_distance([_nucleotide1 | strand1], [_nucleotide2 | strand2], dist),
    do: calc_hamming_distance(strand1, strand2, dist)
  defp calc_hamming_distance([], [], dist), do: dist
end
