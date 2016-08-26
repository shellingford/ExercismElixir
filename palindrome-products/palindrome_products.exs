defmodule Palindromes do
	require Logger
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
  	products =
  		for x <- min_factor..max_factor,
			y <- x..max_factor,
			palindrome?(Integer.to_string(x * y)),
			do: {x * y, [x, y]}
	  Enum.reduce(products, %{}, fn({product, list}, map) -> Map.update(map, product, [list], fn(x) -> x ++ [list] end) end)
  end

  defp palindrome?(str), do: str == String.reverse(str)
end
