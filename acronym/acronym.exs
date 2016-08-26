defmodule Acronym do
	require Logger
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    acronym_list = for word <- String.split(string, " ") do extract_letters(word) end
    acronym_list
    	|> Enum.join("")
    	|> String.upcase
  end

  defp extract_letters(word) do
  	first_letter = String.at(word, 0)
  	other_letters = word
  		|> String.slice(1, String.length(word) - 1)
		  |> String.to_charlist
		  |> Enum.map(&check_letter/1)
		  |> String.Chars.to_string

	Enum.join([first_letter, other_letters], "")
  end

  defp check_letter(letter) do
  	str = String.Chars.to_string([letter])
  	if Regex.match?(~r/\p{Lu}/u, str) do
  		letter
  	else
  		''
  	end
  end
end
