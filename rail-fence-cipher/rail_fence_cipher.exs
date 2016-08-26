defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, 1), do: str
  def encode("", _rails), do: ""
  def encode(str, rails) do
    encoded_list = do_encoding(String.graphemes(str), rails, 0, [], :increase_rail)
    Enum.join(encoded_list, "")
  end

  defp do_encoding([], _rails, _current_rail, encoding_list, _), do: encoding_list

  defp do_encoding([letter | other_letters], rails, current_rail, [], :increase_rail) when current_rail == 0 do
    encoding_list = [[letter]]
    do_encoding(other_letters, rails, current_rail + 1, encoding_list, :increase_rail)
  end

  defp do_encoding([letter | other_letters], rails, current_rail, encoding_list, :increase_rail)
    when current_rail < rails - 1 and current_rail > 0 do
        encoding_list = add_letter_to_encoded_list(encoding_list, letter, current_rail)
        do_encoding(other_letters, rails, current_rail + 1, encoding_list, :increase_rail)
      end

  defp do_encoding([letter | other_letters], rails, current_rail, encoding_list, :increase_rail) when current_rail == rails - 1 do
    encoding_list = add_letter_to_encoded_list(encoding_list, letter, current_rail)
    do_encoding(other_letters, rails, current_rail - 1, encoding_list, :decrease_rail)
  end

  defp do_encoding([letter | other_letters], rails, current_rail, encoding_list, :decrease_rail) when current_rail > 0 do
    encoding_list = add_letter_to_encoded_list(encoding_list, letter, current_rail)
    do_encoding(other_letters, rails, current_rail - 1, encoding_list, :decrease_rail)
  end

  defp do_encoding([letter | other_letters], rails, current_rail, encoding_list, :decrease_rail) when current_rail == 0 do
    encoding_list = add_letter_to_encoded_list(encoding_list, letter, current_rail)
    do_encoding(other_letters, rails, current_rail + 1, encoding_list, :increase_rail)
  end

  defp add_letter_to_encoded_list(encoding_list, letter, current_rail) when length(encoding_list) > current_rail do
    List.replace_at(encoding_list, current_rail, Enum.at(encoding_list, current_rail) ++ [letter])
  end

  defp add_letter_to_encoded_list(encoding_list, letter, current_rail) when length(encoding_list) <= current_rail do
    encoding_list ++ [[letter]]
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, 1), do: str
  def decode("", _rails), do: ""

  def decode(str, rails) do
    Enum.join(do_decode(str, rails, 0, String.graphemes(str), 0), "")
  end

  defp do_decode(str, rails, current_rail, letters, letter_pos) when current_rail == 0 do
    offset = 2 * rails - 2
    {letters, letter_pos} = pick_letters(str, 0, [offset, offset], String.length(str), :first_offset, letters, letter_pos)
    do_decode(str, rails, current_rail + 1, letters, letter_pos)
  end

  defp do_decode(str, rails, current_rail, letters, letter_pos) when current_rail == rails - 1 do
    offset = 2 * rails - 2
    {letters, _letter_pos} = pick_letters(str, current_rail, [offset, offset], String.length(str), :first_offset, letters, letter_pos)
    letters
  end

  defp do_decode(str, rails, current_rail, letters, letter_pos) do
    first_offset = 2 * rails - 2 - current_rail * 2
    second_offset = 2 * rails - 2 - first_offset
    {letters, letter_pos} = pick_letters(str, current_rail, [first_offset, second_offset], String.length(str), :first_offset, letters, letter_pos)
    do_decode(str, rails, current_rail + 1, letters, letter_pos)
  end

  defp pick_letters(_str, position, _offsets, max_position, _, letters, letter_pos) when position >= max_position, do: {letters, letter_pos}
  defp pick_letters(str, position, [first_offset, second_offset], max_position, :first_offset, letters, letter_pos) do
    letters = replace_letters(letters, position, str, letter_pos)
    pick_letters(str, position + first_offset, [first_offset, second_offset], max_position, :second_offset, letters, letter_pos + 1)
  end

  defp pick_letters(str, position, [first_offset, second_offset], max_position, :second_offset, letters, letter_pos) do
    letters = replace_letters(letters, position, str, letter_pos)
    pick_letters(str, position + second_offset, [first_offset, second_offset], max_position, :first_offset, letters, letter_pos + 1)
  end

  defp replace_letters(letters, position, str, letter_pos),
    do: List.replace_at(letters, position, String.at(str, letter_pos))

end
