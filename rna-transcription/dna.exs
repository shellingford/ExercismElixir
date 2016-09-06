defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
  	do_conversion(dna)
  end

  defp do_conversion([nucleotide | dna]) do
  	if (is_valid_nucleotide_or_raise_error(nucleotide)) do
  		rna_nucleotide = dna_to_rna(nucleotide)
  		[rna_nucleotide | do_conversion(dna)]
  	end
  end

  defp do_conversion([]), do: []
  
  #	Given a DNA strand, its transcribed RNA strand is formed by replacing each nucleotide with its complement:
  #	 G -> C
  #  C -> G
  #	 T -> A
  #	 A -> U
  defp dna_to_rna(?G), do: ?C
  defp dna_to_rna(?C), do: ?G
  defp dna_to_rna(?T), do: ?A
  defp dna_to_rna(?A), do: ?U

  defp is_valid_nucleotide_or_raise_error(char) when char in [?A, ?T, ?C, ?G], do: true
  defp is_valid_nucleotide_or_raise_error(_char), do: raise ArgumentError
end
