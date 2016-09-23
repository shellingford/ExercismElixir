defmodule Luhn do
  @doc """
  Calculates the total checksum of a number

  The formula verifies a number against its included check digit, which is usually appended to a partial number to generate the full number. This number must pass the following test:

  Counting from rightmost digit (which is the check digit) and moving left, double the value of every second digit.
  For any digits that thus become 10 or more, subtract 9 from the result.
    1111 becomes 2121.
    8763 becomes 7733 (from 2×6=12 → 12-9=3 and 2×8=16 → 16-9=7).
  Add all these digits together.
    1111 becomes 2121 sums as 2+1+2+1 to give a check digit of 6.
    8763 becomes 7733, and 7+7+3+3 is 20.
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    do_checksum(Enum.reverse(String.graphemes(number)), 0)
  end

  defp do_checksum([], csum), do: csum
  defp do_checksum([first], csum), do: csum + String.to_integer(first)
  defp do_checksum([first, second | other_digits], csum) do
    dig1 = String.to_integer(first)
    dig2 = recalc_dig2(String.to_integer(second) * 2)
    do_checksum(other_digits, csum + dig2 + dig1)
  end

  defp recalc_dig2(dig2) when dig2 >= 10, do: dig2 - 9
  defp recalc_dig2(dig2) when dig2 < 10, do: dig2

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    rem(checksum(number), 10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    Enum.to_list(0..9)
      |> Enum.map(fn(x) -> number <> Integer.to_string(x) end)
      |> Enum.filter(fn(x) -> valid?(x) end)
      |> Enum.join("")
  end
end
