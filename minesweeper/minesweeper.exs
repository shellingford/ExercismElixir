defmodule Minesweeper do
	require Logger
  @doc """
  http://exercism.io/exercises/elixir/minesweeper/readme
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate(board) do
  	cond do
  		length(board) == 0 -> board
      #if there's only bombs on the board then we don't need to do anything
  		Enum.all?(board, fn(x) -> Regex.match?(~r/^\*+$/, x) end) -> board
      #if there are no bombs on the field then we don't need to do anything
  		Enum.all?(board, fn(x) -> Regex.match?(~r/^\s+$/, x)  end) -> board
  		true -> process_board(board)
  	end
  end

  defp process_board(board) do
  	no_rows = length(board) - 1
  	no_cols = String.length(Enum.at(board, 0)) - 1

  	coord = for x <- 0..no_rows, y <- 0..no_cols, do: {x, y}
  	process_elements(coord, no_rows, no_cols, board)
  end

  defp process_elements([], _no_rows, _no_cols, board), do: board
  defp process_elements([{x, y} | coords], no_rows, no_cols, board) do
  	row = Enum.at(board, x)
  	char = String.at(row, y)
  	board = change_board(char, x, y, no_rows, no_cols,board)
  	process_elements(coords, no_rows, no_cols, board)
  end

  defp change_board("*", x, y, no_rows, no_cols, board), do: update_surrounding_elems(x, y, no_rows, no_cols, board)
  defp change_board(_char, _x, _y, _no_rows, _no_cols, board), do: board

  defp update_surrounding_elems(x, y, no_rows, no_cols, board) do
  	board = increase_number(x, y + 1, no_rows, no_cols, board)
  	board = increase_number(x, y - 1, no_rows, no_cols, board)

  	board = increase_number(x + 1, y, no_rows, no_cols, board)
  	board = increase_number(x - 1, y, no_rows, no_cols, board)

  	board = increase_number(x + 1, y + 1, no_rows, no_cols, board)
  	board = increase_number(x + 1, y - 1, no_rows, no_cols, board)

  	board = increase_number(x - 1, y + 1, no_rows, no_cols, board)
  	increase_number(x - 1, y - 1, no_rows, no_cols, board)
  end

  defp increase_number(x, y, no_rows, no_cols, board) when x >= 0 and x <= no_rows and y >= 0 and y <= no_cols do
  	row = Enum.at(board, x)
  	char = String.at(row, y)

  	char = replace_char(char)
	  row = row
  		|> String.graphemes
  		|> List.replace_at(y, char)
  		|> Enum.join("")

	  List.replace_at(board, x, row)
  end
  defp increase_number(_x, _y, _no_rows, _no_cols, board), do: board

  defp replace_char(" "), do: "1" 
  defp replace_char("*"), do: "*"
  defp replace_char(char) do
  	if Regex.match?(~r/[1-7]{1}/, char) do
  		Integer.to_string(String.to_integer(char) + 1)
  	else
  		char
  	end
  end
end
