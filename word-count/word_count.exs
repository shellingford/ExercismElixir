defmodule Words do
	require Logger

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    words = Regex.scan(~r/[\p{L&}\p{Nd}-]+/u, String.downcase(sentence))
    words
      |> List.flatten
      |> Enum.reduce(Map.new, fn(word, word_map) -> Map.update(word_map, word, 1, &(&1 + 1)) end)
  end
end
