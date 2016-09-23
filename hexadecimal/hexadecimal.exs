defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer  
  def to_decimal(hex) do
    if not Regex.match?(~r/^[a-fA-F0-9]+$/, hex) do
      0
    else 
      hex
        |> String.downcase
        |> String.reverse
        |> String.graphemes
        |> convert_decimals(0)
    end
  end

  defp convert_decimals([], _power), do: 0
  defp convert_decimals([digit | other_digits], power),
    do: convert_to_dec(digit) * round(:math.pow(16, power)) + convert_decimals(other_digits, power + 1)

  defp convert_to_dec(hex) when hex in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], do: String.to_integer(hex)
  defp convert_to_dec(hex) when hex in ["a", "b", "c", "d", "e", "f"], do: hex_letter_to_dec(hex)

  defp hex_letter_to_dec("a"), do: 10
  defp hex_letter_to_dec("b"), do: 11
  defp hex_letter_to_dec("c"), do: 12
  defp hex_letter_to_dec("d"), do: 13
  defp hex_letter_to_dec("e"), do: 14
  defp hex_letter_to_dec("f"), do: 15

end
