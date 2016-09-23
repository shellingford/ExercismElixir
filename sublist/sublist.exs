defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
  	cond do
  		are_equal(a, b) -> :equal
  		is_sublist(a, b) -> :sublist
  		is_superlist(a, b) -> :superlist
  		true -> :unequal
  	end

  end

  defp are_equal(a, b), do: a == b

  defp is_sublist(a, b) when length(a) > length(b), do: false
  defp is_sublist(a, b) do
    if (a === Enum.take(b, length(a))) do
      true
    else
      is_sublist(a, tl(b))
    end
  end

  defp is_superlist(a, b), do: is_sublist(b, a)
end
