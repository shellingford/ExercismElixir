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
    chess_board(queens)
  end

  defp chess_board(queens) do
    0 |> rows
      |> Enum.reduce([], fn(row, list) -> list ++ chess_board_row(row, queens.white, queens.black) end)
      |> Enum.join("\n")
  end

  #create list of {x,y} coordinates for all positions on a chess board
  defp rows(x) when x > 7, do: []
  defp rows(x) do
    row = for y <- 0..7, do: {x, y}
    [row] ++ rows(x + 1)
  end

  defp chess_board_row(row, white_queen, black_queen) do
    row = row 
      |> Enum.map(fn(coord) -> row_elem_to_str(coord, white_queen, black_queen) end)
      |> Enum.join(" ")
    [row]
  end

  defp row_elem_to_str({x, y}, {whiteX, whiteY}, _black_queen) when x == whiteX and y == whiteY, do: "W"
  defp row_elem_to_str({x, y}, _white_queen, {blackX, blackY}) when x == blackX and y == blackY, do: "B"
  defp row_elem_to_str(_coord, _white_queen, _black_queen) , do: "_"

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    {blackX, blackY} = queens.black
    {whiteX, whiteY} = queens.white

    can_queen_attack?(whiteX, whiteY, blackX, blackY)
  end

  defp can_queen_attack?(whiteX, _whiteY, blackX, _blackY) when blackX == whiteX, do: true
  defp can_queen_attack?(_whiteX, whiteY, _blackX, blackY) when blackY == whiteY, do: true
  defp can_queen_attack?(whiteX, whiteY, blackX, blackY) when abs(blackX - whiteX) == abs(blackY - whiteY), do: true
  defp can_queen_attack?(_whiteX, _whiteY, _blackX, _blackY), do: false
end
