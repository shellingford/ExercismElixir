defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
  	2..limit
  		|> Enum.to_list
  		|> find_primes
  end

  defp find_primes([]), do: []
  defp find_primes([prime | other_numbers]) do
  	other_numbers = other_numbers |> Enum.filter(fn(x) -> rem(x, prime) != 0 end)
  	[prime] ++ find_primes(other_numbers)
  end

end
