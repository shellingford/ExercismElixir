defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    if String.length(string) > 0 do
      letter_list = count_letters(String.graphemes(string), 1, [])
      List.to_string(for {letter, count} <- letter_list do Integer.to_string(count) <> letter end)
    else 
      ""
    end
  end

  defp count_letters([first_letter, second_letter | other_letters], count, []) when first_letter == second_letter do
    letters_to_count = [second_letter] ++ other_letters
    count = count + 1
    count_letters(letters_to_count, count, [])
  end

  defp count_letters([first_letter, second_letter | other_letters], count, []) do
    letter_list = [{first_letter, count}]
    other_letters = [second_letter] ++ other_letters
    count_letters(other_letters, 1, letter_list)
  end

  defp count_letters([first_letter, second_letter | other_letters], count, letter_list) when first_letter == second_letter do
    letters_to_count = [second_letter] ++ other_letters
    count = count + 1
    count_letters(letters_to_count, count, letter_list)
  end

  defp count_letters([first_letter, second_letter | other_letters], count, letter_list) do
    letter_list = letter_list ++ [{first_letter, count}]
    other_letters = [second_letter] ++ other_letters
    count_letters(other_letters , 1, letter_list)
  end

  defp count_letters([last_letter], count, letter_list) do
    letter_list ++ [{last_letter, count}]
  end 

  @spec decode(String.t) :: String.t
  def decode(string) do
    if String.length(string) > 0 do
      letter_groups = Regex.scan(~r/[0-9]+[A-Z]+/, string)
      extract_chars(letter_groups, "")
    else 
      ""
    end
  end

  defp extract_chars([group | other_groups], string) do
    group = List.to_string(group) #group of a number (n digits) and a single letter
    count_as_int = String.to_integer(String.slice(group, 0, String.length(group) - 1))
    string = string <> String.duplicate(String.at(group, String.length(group) - 1), count_as_int)
    extract_chars(other_groups, string)
  end

  defp extract_chars([], string), do: string
end
