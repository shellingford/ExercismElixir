defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_number_string, size) when size == 0, do: 1
  def largest_product("", size) when size > 0, do: raise ArgumentError
  def largest_product(_number_string, size) when size < 0, do: raise ArgumentError

  def largest_product(number_string, size) do
    number_string 
      |> String.graphemes
      |> Enum.map(&String.to_integer/1)
      |> chunks(size)
      |> Enum.map(fn(sublist) -> List.foldl(sublist, 1, &(&1 * &2)) end)
      |> Enum.max
  end

  defp chunks(numbers, size) when size > length(numbers), do: raise ArgumentError
  defp chunks(numbers, size), do: Enum.chunk(numbers, size, 1)

end
