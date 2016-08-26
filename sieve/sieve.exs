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
  	other_numbers = other_numbers |> remove_multiples(prime)
  	[prime] ++ find_primes(other_numbers)
  end

  defp remove_multiples([], _prime), do: []
  defp remove_multiples([number | other_numbers], prime) when rem(number, prime) == 0,
  	do: remove_multiples(other_numbers, prime)
  defp remove_multiples([number | other_numbers], prime), do: [number] ++ remove_multiples(other_numbers, prime)

end
