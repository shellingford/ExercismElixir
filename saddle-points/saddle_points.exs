defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
      |> String.split("\n", trim: true)
      |> Enum.reduce([], fn(x, acc) -> acc ++ [x |> String.split(" ") |> Enum.map(&String.to_integer/1)] end)
  end

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

    #assume matrix is MxN
    for i <- 0..(length(matrix) - 1),
        j <- 0..(length(t_matrix) - 1),
        saddle?(Enum.at(matrix, i), j, &Kernel.>=/2) && saddle?(Enum.at(t_matrix, j), i, &Kernel.<=/2),
        do: {i, j}
  end

  defp saddle?(nums_to_compare, i, compare_fun) do
    current_num = Enum.at(nums_to_compare, i)
    nums_to_compare |> Enum.all?(fn (other_num) -> compare_fun.(current_num, other_num) end)
  end

end
