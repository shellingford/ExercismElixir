defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
  	pascals_triangle_rows(num)
  end

  defp pascals_triangle_rows(num) do
    Enum.reduce(1..num, [], fn(_row_ind, acc) -> acc ++ pascals_triangle_row(List.last(acc)) end)
  end

  defp pascals_triangle_row(nil), do: [[1]]
  defp pascals_triangle_row(previous_row) do
    middle_items = previous_row |> Enum.chunk(2, 1) |> Enum.map(&Enum.sum/1)
    [[1] ++ middle_items ++ [1]]
  end
end
