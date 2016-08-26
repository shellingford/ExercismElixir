defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    do_square(number, 1)
  end

  defp do_square(number, 0) do
    do_square(number - 1, 2)
  end

  defp do_square(number, pow) when number <= 1, do: pow
  defp do_square(number, pow), do: do_square(number - 1, pow * 2)

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    sum_squares(Enum.to_list(1..64), 0)
  end

  defp sum_squares([first | others], 0), do: sum_squares(others, square(first))
  defp sum_squares([first | others], sum), do: sum_squares(others, sum + square(first))
  defp sum_squares([], sum), do: sum
end
