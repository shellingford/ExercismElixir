defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &(dna_to_rna(&1)))
  end
  
  #	Given a DNA strand, its transcribed RNA strand is formed by replacing each nucleotide with its complement:
  #	 G -> C
  #  C -> G
  #	 T -> A
  #	 A -> U
  defp dna_to_rna(?G), do: ?C
  defp dna_to_rna(?C), do: ?G
  defp dna_to_rna(?T), do: ?A
  defp dna_to_rna(?A), do: ?U
end
