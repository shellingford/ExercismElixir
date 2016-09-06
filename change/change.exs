defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    sorted_coins = values |> Enum.sort_by(&(&1), &>=/2)
    coins = sorted_coins |> Enum.map(&{&1, 0}) |> Enum.into(%{})
    counted_coins(sorted_coins, amount, coins)
  end

  defp counted_coins(_other_coins, amount, coins) when amount == 0, do: {:ok, coins}
  defp counted_coins([], amount, _coins) when amount > 0, do: :error
  defp counted_coins(_other_coins, amount, _coins) when amount < 0, do: :error

  defp counted_coins([coin | other_coins], amount, coins) when coin > (amount - coin) do
    res = counted_coins(other_coins, amount - coin, Map.update!(coins, coin, &(&1 + 1)))
    if counting_done?(res) do
      res
    else
      counted_coins(other_coins, amount, coins)
    end
  end

  defp counted_coins([coin | other_coins], amount, coins) do
    res = counted_coins([coin | other_coins], amount - coin, Map.update!(coins, coin, &(&1 + 1)))
    if counting_done?(res) do
      res
    else
      counted_coins(other_coins, amount, coins)
    end
  end

  defp counting_done?(:error), do: false
  defp counting_done?({:ok, _coins}), do: true

end
