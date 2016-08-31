defmodule Minesweeper do
  @doc """
  http://exercism.io/exercises/elixir/minesweeper/readme
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]
  def annotate(board) when length(board) == 0, do: board
  def annotate(board) do
    process_board(
      not(Enum.all?(board, fn(x) -> Regex.match?(~r/^\*+$/, x) end) or 
          Enum.all?(board, fn(x) -> Regex.match?(~r/^\s+$/, x)  end)),
      board)
  end

  defp process_board(false, board), do: board
  defp process_board(true, board) do
    map = board |> board_to_map
    map
     |> Enum.filter(fn({_key, v}) -> v == "*" end)
     |> annotated_map(map)
     |> map_to_board(length(board))
  end

  defp board_to_map(board) do
      board 
        |> Enum.with_index 
        |> Enum.reduce(%{},
            fn({row, indX}, acc) -> 
              Enum.reduce(
                Enum.with_index(String.graphemes(row)),
                acc,
                fn({char, indY}, acc) -> Map.put(acc, {indX, indY}, char) end)
            end)
    end

  defp annotated_map([], map), do: map
  defp annotated_map([{{x, y}, _v} | other_bombs], map) do
    neighbours = neighbours(x, y)
    map = map
      |> Enum.filter(fn({coords, _v}) -> coords in neighbours end)
      |> Enum.reduce(map, fn({key, _v}, acc) -> Map.update!(acc, key, &replace_char/1) end)

    annotated_map(other_bombs, map)
  end

  defp neighbours(x, y) do
    for i <- -1..1, 
        j <- -1..1, 
        {i, j} != 0,
        do: {x + i, y + j}
  end

  #replaces current char with number of mines
  defp replace_char(" "), do: "1" 
  defp replace_char("*"), do: "*"
  defp replace_char(char), do: Integer.to_string(String.to_integer(char) + 1)

  #recreate board as list of strings from the map
  defp map_to_board(map, board_length) do
    Enum.reduce(
      Enum.to_list(0..board_length - 1),
      [],
      fn(ind, acc) -> acc ++ [create_row_from_map(map, ind)] end)
  end

  defp create_row_from_map(map, ind) do
    map |> Enum.filter(fn({{x, _y}, _v}) -> x == ind end)
        |> Enum.map(fn({_key, v}) -> v end)
        |> Enum.join("")
  end

end
