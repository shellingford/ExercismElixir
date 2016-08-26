defmodule PrimeFactors do
	require Logger
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) when number <= 3 do
  	compute_factors(number, 2, number, [])
  end

  def factors_for(number) do
  	compute_factors(number, 2, round(:math.sqrt(number)), [])
  end

  defp compute_factors(1, _divisor, _max_divisor, prime_factors), do: prime_factors

  defp compute_factors(number, divisor, max_divisor, prime_factors) when divisor > max_divisor do 
  	prime_factors = prime_factors ++ [number]
  	prime_factors
  end

  defp compute_factors(number, divisor, max_divisor, []) when rem(number, divisor) == 0 do
  	prime_factors = [divisor]
  	number = round(number / divisor)
  	compute_factors(number, divisor, max_divisor, prime_factors)
  end

  defp compute_factors(number, divisor, max_divisor, prime_factors) when rem(number, divisor) == 0 do
  	prime_factors = prime_factors ++ [divisor]
  	number = round(number / divisor)
  	compute_factors(number, divisor, max_divisor, prime_factors)
  end

  defp compute_factors(number, divisor, max_divisor, prime_factors) when rem(number, divisor) != 0 do
  	compute_factors(number, divisor + 1, max_divisor, prime_factors)
  end

end
