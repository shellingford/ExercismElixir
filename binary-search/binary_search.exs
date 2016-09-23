defmodule BinarySearch do
  @doc """
    Searches for a key in the list using the binary search algorithm.
    It returns :not_found if the key is not in the list.
    Otherwise returns the tuple {:ok, index}.

    ## Examples

      iex> BinarySearch.search([], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 5)
      {:ok, 2}

  """

  @spec search(Enumerable.t, integer) :: {:ok, integer} | :not_found
  def search(list, _key) when length(list) == 0 do
    :not_found
  end

  def search(list, key) do
    if list != Enum.sort(list) do
      raise ArgumentError, "expected list to be sorted"
    end

    {first_half, second_half, middle_index} = split_list(list)
    do_search(first_half, second_half, middle_index, Enum.at(list, middle_index), key)
  end

  defp do_search(_first_half, _second_half, index, list_elem, key) when key == list_elem, do: {:ok, index}

  defp do_search([], _second_half, _index, list_elem, key) when key != list_elem, do: :not_found

  defp do_search(_first_half, [], _index, list_elem, key) when key != list_elem, do: :not_found

   defp do_search(_first_half, second_half, index, list_elem, key) when key > list_elem do
    {first_half, new_second_half, middle_index} = split_list(second_half)
    do_search(first_half, new_second_half, middle_index + index, Enum.at(second_half, middle_index), key)
   end

   defp do_search(first_half, _second_half, index, list_elem, key) when key < list_elem do
    {new_first_half, second_half, middle_index} = split_list(first_half)
    do_search(new_first_half, second_half, first_half_mid_ind(index, middle_index), Enum.at(first_half, middle_index), key)
   end

   defp split_list(list) do
    middle_index = div(length(list), 2)
    Tuple.append(Enum.split(list, middle_index), middle_index)
   end

   defp first_half_mid_ind(_index, 0), do: 0
   defp first_half_mid_ind(index, mid_ind), do: index - mid_ind

end
