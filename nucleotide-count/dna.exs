defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    validate_strand(strand ++ [nucleotide])
    Enum.count(strand, &(&1 == nucleotide))
  end

  defp validate_strand(strand) do
    if (not Enum.all?(strand, &is_valid_nucleotide/1)), do: raise ArgumentError
  end

  defp is_valid_nucleotide(nucleotide) when nucleotide in [?A, ?T, ?C, ?G, ''], do: true
  defp is_valid_nucleotide(_nucleotide), do: false

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    validate_strand(strand)
    histogram =  %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    Enum.reduce(strand, histogram, fn(nucleotide, histogram) -> Map.update!(histogram, nucleotide, &(&1 + 1)) end)
  end

end
