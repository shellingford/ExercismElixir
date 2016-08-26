defmodule Series do
	require Logger
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_number_string, size) when size == 0, do: 1
  def largest_product("", size) when size > 0, do: raise ArgumentError
  def largest_product(_number_string, size) when size < 0, do: raise ArgumentError

  def largest_product(number_string, size) do
  	no_iter = String.length(number_string) - size + 1
  	find_max_product(number_string, 0, no_iter, size)
  end

  defp find_max_product(_number_string, _start_iter, no_iter, _size) when no_iter <= 0, do: raise ArgumentError
  defp find_max_product(_number_string, start_iter, no_iter, _size) when start_iter == no_iter, do: 0

  defp find_max_product(number_string, start_iter, no_iter, size) do
  	product = number_string
  		|> String.slice(start_iter..(start_iter + size - 1))
  		|> String.graphemes
  		|> calc_product

  	max(product, find_max_product(number_string, start_iter + 1, no_iter, size))
  end

  defp calc_product(number_substring), do: Enum.reduce(number_substring, 1, fn(x, acc) -> String.to_integer(x) * acc end)

end
