defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
  	calc_rows(num, 1, [])
  end
  defp calc_rows(max_row, current_row, []), do: calc_rows(max_row, current_row + 1, [[1]])
  defp calc_rows(max_row, current_row, rows_before) when current_row > max_row, do: rows_before
  defp calc_rows(max_row, current_row, rows_before) when current_row <= max_row,
    do: calc_rows(max_row, current_row + 1, rows_before ++ create_row(List.last(rows_before), []))

  defp create_row([first | others_from_row_before], []) when length(others_from_row_before) > 0,
    do: create_row([first | others_from_row_before], [first])
  defp create_row([first | others_from_row_before], []) when length(others_from_row_before) == 0,
  	do: create_row(others_from_row_before, [first, first])
  defp create_row([first, second | others_from_row_before], current_row),
  	do: create_row([second | others_from_row_before], current_row ++ [(first + second)])
  defp create_row([last | others_from_row_before], current_row) when length(others_from_row_before) == 0,
  	do: create_row(others_from_row_before, current_row ++ [last])
  defp create_row([], current_row), do: [current_row]

end
