defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    string
      |> String.trim
      |> String.graphemes
      |> Enum.reverse
      |> convert_to_decimal(0, 0)
  end

  defp convert_to_decimal(["0" | other_chars], digit_counter, dec_num), do: convert_to_decimal(other_chars, digit_counter + 1, dec_num)
  defp convert_to_decimal(["1" | other_chars], digit_counter, dec_num) do
    digit = :math.pow(2, digit_counter) |> round
    convert_to_decimal(other_chars, digit_counter + 1, dec_num + digit)
  end

  defp convert_to_decimal([_invalid_char | _other_chars], _digit_counter, _dec_num), do: 0
  defp convert_to_decimal([], _digit_counter, dec_num), do: dec_num
end
