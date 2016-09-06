defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet) do
    List.foldl(triplet, 0, fn(x, acc) -> x + acc end)
  end

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet) do
    List.foldl(triplet, 1, fn(x, acc) -> x * acc end)
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) do
    a*a + b*b == c*c
  end

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max) do
    min..max
      |> Enum.to_list
      |> Enum.map(fn(x) -> x * x end)
      |> triplets(fn(a, b, c, _) -> c == a + b end, 0)
  end

  defp triplets(nums, _fn_compare, _sum) when length(nums) < 3, do: []
  defp triplets([num | other_nums], fn_compare, sum) do
    find_triplets(num, other_nums, fn_compare, sum) ++ triplets(other_nums, fn_compare, sum)
  end

  #for set first number finds other two numbers for pythagorean triplet (if they exist)
  defp find_triplets(_num, [], _fn_compare, _sum), do: []
  defp find_triplets(a, [b | other_nums], fn_compare, sum) do
    {found_triplet, c} = last_triplet_number(a, b, other_nums, sum, fn_compare)
    if (found_triplet) do
      [sqrt_triplets(a, b, c)] ++ find_triplets(a, other_nums, fn_compare, sum)
    else
      find_triplets(a, other_nums, fn_compare, sum)
    end
  end

  defp last_triplet_number(a, b, other_nums, sum, fn_compare) do
    c = Enum.find(other_nums, -1, fn(c) -> fn_compare.(a, b, c, sum) end)
    {c > 0, c}
  end

  defp sqrt_triplets(a, b, c), do: [round(:math.sqrt(a)), round(:math.sqrt(b)), round(:math.sqrt(c))]

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
    min..max
      |> Enum.to_list
      |> Enum.map(fn(x) -> x * x end)
      |> triplets(fn(a, b, c, sum) -> c == a + b and 
          round(:math.sqrt(a)) + round(:math.sqrt(b)) + round(:math.sqrt(c)) == sum end, sum)
  end

end
