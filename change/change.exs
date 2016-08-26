defmodule Change do
  require Logger
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
    coins = values
      |> Enum.sort_by(&(&1), &>=/2)
      |> Enum.map(&{&1, 0})

      #not finished...
    iterate_all_coins(amount, coins, %{})
  end

  #we must iterate over all coins to see if we can use any of them, so we need
  #to have backtracking function that resets search if not found with current coin list
  defp iterate_all_coins(amount, [largest_coin | other_coins], map) do
    res = check(amount, [largest_coin | other_coins], map)
    case res do
      :error -> 
          {coin, value} = largest_coin
          iterate_all_coins(amount, other_coins, put_in(map[largest_coin], 0))
      _ -> res
    end
  end

  defp iterate_all_coins(_amount, [], _map) do
    :error
  end

  defp check(0, coins, map), do: { :ok, Enum.into(coins, map) }

  defp check(remaining_amount, [{coin, coin_count} | other_coins], map)
    when remaining_amount >= coin, do 
      case check(rem(remaining_amount, coin), other_coins, put_in(map[coin], div(remaining_amount, coin))) do
        
      end
    end

  defp check(remaining_amount, [{coin, _coin_count} | other_coins], map)
    when remaining_amount < coin,
    do: check(remaining_amount, other_coins, put_in(map[coin], 0))
    
  defp check(_remaining_amount, _coin_list, _coin_map), do: :error
end
