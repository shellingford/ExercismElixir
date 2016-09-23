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
    chess_board()
      |> Enum.map(&(position_to_str(&1, queens.white, queens.black)))
      |> Enum.chunk(8)
      |> Enum.map_join("\n", &(Enum.join(&1, " ")))
  end

  defp chess_board do
    for x <- 0..7,
        y <- 0..7,
        do: {x, y}
  end

  defp position_to_str({x, y}, {whiteX, whiteY}, _black_queen) when x == whiteX and y == whiteY, do: "W"
  defp position_to_str({x, y}, _white_queen, {blackX, blackY}) when x == blackX and y == blackY, do: "B"
  defp position_to_str(_coord, _white_queen, _black_queen) , do: "_"

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    can_queen_attack?(queens.white, queens.black)
  end

  defp can_queen_attack?({whiteX, _whiteY}, {blackX, _blackY}) when blackX == whiteX, do: true
  defp can_queen_attack?({_whiteX, whiteY}, {_blackX, blackY}) when blackY == whiteY, do: true
  defp can_queen_attack?({whiteX, whiteY}, {blackX, blackY}) when abs(blackX - whiteX) == abs(blackY - whiteY), do: true
  defp can_queen_attack?(_white, _black), do: false
end
