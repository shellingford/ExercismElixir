defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, 1), do: str
  def encode("", _rails), do: ""
  def encode(str, rails) do
    enc_rails = encoded_rails(str, rails)
    1..rails |> Enum.map_join("", fn(x) -> Enum.map(enc_rails, fn(y) -> extract_encoded_str(y, x - 1) end) end)
  end

  defp encoded_rails(str, rails) do
    rail_cols = Enum.reduce(1..String.length(str), [], fn(_, acc) -> acc ++ [String.duplicate("~", rails)] end)
    do_encoding(String.graphemes(str), rail_cols, 0, rails, :increase_rail)
  end

  defp do_encoding([], _encoded_list, _current_rail, _rails, _), do: []

  defp do_encoding([letter | other_letters], [encoded_col | encoded_list], current_rail, rails, :increase_rail) when current_rail == rails - 1 do
    encoded_col = replace_char(encoded_col, letter, current_rail)
    [encoded_col] ++ do_encoding(other_letters, encoded_list, current_rail - 1, rails, :decrease_rail)
  end

  defp do_encoding([letter | other_letters], [encoded_col | encoded_list], current_rail, rails, :increase_rail) do
    encoded_col = replace_char(encoded_col, letter, current_rail)
    [encoded_col] ++ do_encoding(other_letters, encoded_list, current_rail + 1, rails, :increase_rail)
  end

  defp do_encoding([letter | other_letters], [encoded_col | encoded_list], current_rail, rails, :decrease_rail) when current_rail == 0 do
    encoded_col = replace_char(encoded_col, letter, current_rail)
    [encoded_col] ++ do_encoding(other_letters, encoded_list, current_rail + 1, rails, :increase_rail)
  end

  defp do_encoding([letter | other_letters], [encoded_col | encoded_list], current_rail, rails, :decrease_rail) do
    encoded_col = replace_char(encoded_col, letter, current_rail)
    [encoded_col] ++ do_encoding(other_letters, encoded_list, current_rail - 1, rails, :decrease_rail)
  end

  defp replace_char(str, new_letter, index),
    do: str |> String.graphemes |> List.replace_at(index, new_letter) |> Enum.join("")

  defp extract_encoded_str(str, ind) do
    cond do
      "~" == String.at(str, ind) -> ""
      true -> String.at(str, ind)
    end
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, 1), do: str
  def decode("", _rails), do: ""

  def decode(str, rails) do
    enc_rails = String.duplicate("?", String.length(str)) |> encoded_rails(rails)
    letters_per_rails = letters_per_rails(str, rails, enc_rails)
    do_decode(enc_rails, letters_per_rails)
  end

  defp letters_per_rails(str, rails, enc_rails) do
    letter_mapping = Enum.map(1..rails, fn(x) -> {x, Enum.count(enc_rails, fn(y) -> String.at(y, x-1) == "?" end)} end) 
    Enum.reduce(letter_mapping, [], &(map_letters(&1, &2, str, letter_mapping)))
  end

  defp do_decode([], _letter_groups), do: ""

  defp do_decode([rail_col | other_rail_columns], letter_groups) do
    {ind, _} = :binary.match(rail_col, "?")
    {letter, letter_groups} = extract_letter_and_update_group(letter_groups, ind)
    letter <> do_decode(other_rail_columns, letter_groups)
  end

  defp extract_letter_and_update_group(letter_groups, ind) do
    letters = Enum.at(letter_groups, ind)
    letter = String.at(letters, 0)
    letters = String.slice(letters, 1, String.length(letters))
    letter_groups = List.replace_at(letter_groups, ind, letters)
    {letter, letter_groups}
  end

  defp map_letters({1, letter_count}, acc, str, _letter_mapping), do: acc ++ [String.slice(str, 0, letter_count)]
  defp map_letters({index, letter_count}, acc, str, letter_mapping) do
    start_str_ind = 
      letter_mapping |> Enum.slice(0..index - 2)
                     |> Enum.map(fn({_, c}) -> c end)
                     |> Enum.sum
    acc ++ [String.slice(str, start_str_ind, letter_count)]
  end

end
