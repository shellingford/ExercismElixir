defmodule Words do
	require Logger

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
  	count_words(String.split(sentence, [" ", "_", ":", "!", ".", ","]))
  end

  defp count_words(str_list) do
  	lowercase_list = for value <- str_list do String.downcase(value) end
  	Enum.reduce(lowercase_list, Map.new, &count_word/2)
  end

  defp count_word(str, word_map) do
  	if check_word(String.trim(str)) do
  	 	Map.update(word_map, str, 1, &(&1 + 1))
  	else
  		word_map
  	end
  end

  defp check_word(word) do
  	Regex.match?(~r/^[\w\-]+$/u, word)
  end
end
