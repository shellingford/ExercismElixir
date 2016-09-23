defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(string) do
    letter_list = count_letters(String.graphemes(string), 1, [])
    List.to_string(for {letter, count} <- letter_list do Integer.to_string(count) <> letter end)
  end

  defp count_letters([], _count, letter_list), do: letter_list
  defp count_letters([first_letter, first_letter | other_letters], count, letter_list) do
    count_letters([first_letter | other_letters], count + 1, letter_list)
  end
  defp count_letters([first_letter | other_letters], count, letter_list) do
    letter_list = letter_list ++ [{first_letter, count}]
    count_letters(other_letters, 1, letter_list)
  end

  @spec decode(String.t) :: String.t
  def decode(""), do: ""
  def decode(string) do
    Regex.scan(~r/[0-9]+[A-Z]+/, string)
      |> List.flatten
      |> Enum.map_join("", fn(x) -> extracted_chars(x) end)
  end

  defp extracted_chars(group) do
    count_as_int = String.to_integer(String.slice(group, 0, String.length(group) - 1))
    String.duplicate(String.at(group, String.length(group) - 1), count_as_int)
  end
end
