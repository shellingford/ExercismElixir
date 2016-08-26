defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
  	find_anagrams(base, candidates)
  end

  defp find_anagrams(base, [candidate | other_candidates]) do
  	if (String.length(base) == String.length(candidate) and
  			String.downcase(base) != String.downcase(candidate) and
  			is_anagram(to_lowercase(String.graphemes(base)), to_lowercase(String.graphemes(candidate)))) do
  		[candidate | find_anagrams(base, other_candidates)]
  	else
  		find_anagrams(base, other_candidates)
  	end
  end

  defp find_anagrams(_base, []) do
  	[]
  end

  defp is_anagram([char | other_base_chars], candidate_chars) do
  	if (Enum.member?(candidate_chars, char) == false) do
  		false
  	else
  		is_anagram(other_base_chars, extract_char(char, candidate_chars))
  	end
  end

  defp is_anagram([], _candidate_chars) do
  	true
  end

  defp extract_char(char, [cand_char | other_candidate_chars]) do
  	if (char == cand_char) do
  		other_candidate_chars
  	else 
  		[cand_char | extract_char(char, other_candidate_chars)]
  	end
  end

  defp extract_char(_char, []) do
  	[]
  end

  defp to_lowercase([str | string_list]) do
  	[String.downcase(str) | to_lowercase(string_list)]
  end

  defp to_lowercase([]) do
  	[]
  end
end
