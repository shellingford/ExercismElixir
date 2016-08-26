defmodule Allergies do
    use Bitwise

  @allergies [ "eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats" ]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(0), do: []
  def list(flags) do
    find_allergies(@allergies, flags)
  end

  defp find_allergies([], _flags), do: []
  defp find_allergies([allergy | other_allergies], flags) do
    case flags &&& 1 do
      0 -> find_allergies(other_allergies, flags >>> 1)
      1 -> [allergy] ++ find_allergies(other_allergies, flags >>> 1)
    end
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end
end
