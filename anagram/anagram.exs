defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.reduce(candidates, [], &(anagram(String.downcase(base), &1, &2)))
  end

  defp anagram(base, candidate, anagrams) do
      if (anagram?(String.graphemes(base), String.graphemes(String.downcase(candidate)))) do
        anagrams ++ [candidate]
      else
        anagrams
      end
  end

  defp anagram?(base_chars, candidate_chars) when length(base_chars) == length(candidate_chars) and base_chars != candidate_chars,
    do: length(base_chars -- candidate_chars) == 0
  defp anagram?(_base_chars, _candidate_chars), do: false
end
