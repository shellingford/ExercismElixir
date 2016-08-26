defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3}) do
    if (black == white), do: raise ArgumentError
    %Queens{ black: black, white: white }
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    {blackX, blackY} = queens.black
    {whiteX, whiteY} = queens.white

    create_chess_board(Enum.to_list(0..7), whiteX, whiteY, blackX, blackY, "")
  end

  defp create_chess_board([row | other_rows], whiteX, whiteY, blackX, blackY, board) do
    board = board <> create_row(Enum.to_list(0..7), row, whiteX, whiteY, blackX, blackY, "")
    board = if (row < 7), do: board <> "\n", else: board
    create_chess_board(other_rows, whiteX, whiteY, blackX, blackY, board)
  end

  defp create_chess_board([], _whiteX, _whiteY, _blackX, _blackY, board), do: board

  defp create_row([column | other_columns], row, whiteX, whiteY, blackX, blackY, board) do
    board = append_board(row, column, whiteY, whiteX, blackX, blackY, board)
    create_row(other_columns, row, whiteX, whiteY, blackX, blackY, board)
  end
  defp create_row([], _row, _whiteX, _whiteY, _blackX, _blackY, board), do: board

  defp append_board(row, column, whiteY, whiteX, _blackX, _blackY, board) when column == 0 and column == whiteY and row == whiteX,
    do: board <> "W" 
  defp append_board(row, column, whiteY, whiteX, _blackX, _blackY, board) when column > 0 and column == whiteY and row == whiteX,
    do: board <> " W" 
  defp append_board(row, column, _whiteY, _whiteX, blackX, blackY, board) when column == 0 and column == blackY and row == blackX,
    do: board <> "B" 
  defp append_board(row, column, _whiteY, _whiteX, blackX, blackY, board) when column > 0 and column == blackY and row == blackX ,
    do: board <> " B" 
  defp append_board(_row, column, _whiteY, _whiteX, _blackX, _blackY, board) when column == 0,
    do: board <> "_" 
  defp append_board(_row, column, _whiteY, _whiteX, _blackX, _blackY, board) when column > 0,
    do: board <> " _" 

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    {blackX, blackY} = queens.black
    {whiteX, whiteY} = queens.white

    cond do
      blackX == whiteX -> true
      blackY == whiteY -> true
      abs(blackX - whiteX) == abs(blackY - whiteY) -> true
      true -> false
    end
  end
end
