defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
  	prime_factors(number, 2, [])
  end

  defp prime_factors(num, possible_factor, factors) when possible_factor > num, do: factors
  defp prime_factors(num, possible_factor, factors) when rem(num, possible_factor) == 0,
    do: prime_factors(div(num, possible_factor), possible_factor, factors ++ [possible_factor])
  defp prime_factors(num, possible_factor, factors),
    do: prime_factors(num, possible_factor + 1, factors)
end
