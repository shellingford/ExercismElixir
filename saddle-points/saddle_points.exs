defmodule Matrix do
  require Logger
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
      |> String.split("\n", trim: true)
      |> parse_rows
  end

  defp parse_rows([]), do: [] 
  defp parse_rows([str_row | other_rows]), do: [parse_row(String.split(str_row, " "), [])] ++ parse_rows(other_rows)


  defp parse_row([], []), do: []
  defp parse_row([], row), do: row
  defp parse_row([char | other_chars], []), do: parse_row(other_chars, [String.to_integer(char)])
  defp parse_row([char | other_chars], row), do: parse_row(other_chars, row ++ [String.to_integer(char)])

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
      |> rows
      |> List.zip
      |> List.foldl([],  fn(x, acc) -> acc ++ [Tuple.to_list(x)] end)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    matrix = rows(str)
    t_matrix = columns(str)

    #assume matrix is not NxN, but MxN
    create_pairs(length(matrix), length(t_matrix))
      |> Enum.filter(fn ({i, j}) ->
          col = Enum.at(t_matrix, j)
          row = Enum.at(matrix, i)
          is_saddle(row, j, &Kernel.>=/2) && is_saddle(col, i, &Kernel.<=/2)
        end)
  end

  defp is_saddle(nums_to_compare, i, compare_fun) do
    current_num = Enum.at(nums_to_compare, i)
    nums_to_compare
      |> Enum.all?(fn (other_num) -> compare_fun.(current_num, other_num) end)
  end

  defp create_pairs(row_no, col_no) do
    for i <- 0..(row_no - 1), j <- 0..(col_no - 1), do: {i, j}
  end

end
