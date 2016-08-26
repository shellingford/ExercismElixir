defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
  	cond do
  		are_equal(a, b) == true -> :equal
  		is_sublist(a, b) == true -> :sublist
  		is_superlist(a, b) == true -> :superlist
  		true -> :unequal
  	end

  end

  defp are_equal(a, b), do: a == b

  defp is_sublist(a, b) when length(a) >= length(b), do: false
  defp is_sublist(a, b), do: find_sublist(a, b, false, a, b)


  defp find_sublist([a_elem | a_other_elems], [b_elem | b_other_elems], found_first_elem, copy_of_a, [last_starting_elem_b | copy_of_b]) do
  	cond do
  		found_first_elem == true and a_elem !== b_elem -> 
  			#if we failed to find a sublist within B list, then we need to restart our search, but not from the start of
  			#B list, but from the next element where we last started the search (last_starting_elem_b). This is the only
  			#time we need to resize copy_of_b list as other elements won't be searched again
  			find_sublist(copy_of_a, copy_of_b, false, copy_of_a, copy_of_b)
  		found_first_elem == false and a_elem !== b_elem and length(a_other_elems) + 1 > length(b_other_elems) -> 
  			#if we need to continue searching for first equal element in the lists but currently size of list A is greater
  			#than remaining size of list B, then we can stop searching as list A can't be sublist of list B
  			false
  		found_first_elem == false and a_elem !== b_elem -> 
  			#continue searching for first equal element in the lists
  			find_sublist([a_elem | a_other_elems], b_other_elems, false, copy_of_a, [last_starting_elem_b | copy_of_b])
  		a_elem === b_elem -> 
  			#we found first equal element in the lists (now or before, doesn't matter in this case) and we continue
  			#comparing equal elements in both lists
  			find_sublist(a_other_elems, b_other_elems, true, copy_of_a, [last_starting_elem_b | copy_of_b])

  	end
  end

  defp find_sublist([], _, _, _, _ ), do: true

  defp is_superlist(a, b), do: is_sublist(b, a)
end
