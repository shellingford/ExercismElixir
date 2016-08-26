defmodule DNA do
  require Logger
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
    if (is_valid_nucleotide_or_raise_error(nucleotide)) do
      do_count(strand, nucleotide, 0)
    else
      raise ArgumentError
    end
  end

  defp do_count([], _nucleotide, count), do: count
  defp do_count([char | strand], nucleotide, count) do
    if (is_valid_nucleotide_or_raise_error(char) and char == nucleotide) do
      do_count(strand, nucleotide, count + 1)
    else
      do_count(strand, nucleotide, count)
    end
  end

  defp is_valid_nucleotide_or_raise_error(char) when char in [?A, ?T, ?C, ?G, ''], do: true
  defp is_valid_nucleotide_or_raise_error(_char), do: raise ArgumentError

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    histogram =  %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    do_histogram(strand, histogram)
  end

  defp do_histogram([], histogram), do: histogram
  defp do_histogram([char | strand], histogram)  do
    if (is_valid_nucleotide_or_raise_error(char)) do
      histogram = Map.update!(histogram, char, &(&1 + 1))
      do_histogram(strand, histogram)
    end
  end

end
