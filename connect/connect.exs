defmodule Connect do
	require Logger
  @doc """
  http://exercism.io/exercises/elixir/connect/readme
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player

  When searching if white player won we start from the bottom and try to find
  connection of stones("Y") to the top row.

  When searching if black player won we start from the last column of a row and
  try to find connection of stones("X") to the first column of a row.
  """
  @spec result_for([String.t]) :: :none | :black | :white
  def result_for(["X"]), do: :black
  def result_for(["O"]), do: :white
  def result_for(board) do
  	cond do
  		empty?(board) -> :none
  		white_won?(board) -> :white
  		black_won?(board) -> :black
  		true -> :none
  	end
  end

  defp empty?(board) do
  	Regex.match?(~r/^\.+$/, Enum.join(board, ""))
  end

  defp white_won?(board) do
  	winning_pairs = create_white_win_pairs(board)
    #all white stone positions on a board as pairs {x,y}
  	white_pairs = create_player_pairs(board, "O")

  	winning_white_pairs = winning_pairs -- (winning_pairs -- white_pairs)
  	#if we have at least one pair that could be winning pair then search connection from it to the top row
  	if length(winning_white_pairs) > 0 do
  		#win_func -> if we find connection to the top row, then white won
  		find_connecting_pairs(white_pairs, winning_white_pairs, [], fn(x, _y, v) -> x == v end)
  	else
  		false
  	end
  end

  # pairs {x, y} for winning positions on bottom side of the board (when we start on top side)
  defp create_white_win_pairs(board) do
  	col = board |> Enum.at(0) |> String.graphemes |> length
	  0..col-1 |> Enum.with_index |> Enum.reduce([] ,fn({_x, idx}, acc) -> acc ++ [{length(board) - 1, idx}] end)
  end

  defp black_won?(board) do
  	winning_pairs = create_black_win_pairs(board)
    #all black stone positions on a board as pairs {x,y}
  	black_pairs = create_player_pairs(board, "X")

  	winning_black_pairs = winning_pairs -- (winning_pairs -- black_pairs)
  	#if we have at least one pair that could be winning pair then search connection from it to the first columns of a row
  	if length(winning_black_pairs) > 0 do
  		#win_func -> if we find connection to the first column of a row, then black won
  		find_connecting_pairs(black_pairs, winning_black_pairs, [], fn(_x, y, v) -> y == v end)
  	else
  		false
  	end
  end

  # pairs {x, y} for winning positions on right side of the board (when we start on left side)
  defp create_black_win_pairs(board) do
    col = board |> Enum.at(0) |> String.graphemes |> length
	  board |> Enum.with_index |> Enum.reduce([] ,fn({_x, idx}, acc) -> acc ++ [{idx, col - 1}] end)
  end

  defp create_player_pairs(board, char) do
    board
    |> create_board
    |> Enum.filter(fn {_x, _y, v} -> v == char end)
    |> Enum.map(fn {x, y, _v} -> {x, y} end)
  end

  defp create_board(board) do
	  for x <- 0..length(board) - 1,
	    y <- 0..String.length(Enum.at(board, 0)) - 1,
	    value = board |> Enum.at(x) |> String.at(y),
	    do: {x, y, value}
  end

  defp find_connecting_pairs(_player_pairs, [], _ignore_pairs, _win_func), do: false
  defp find_connecting_pairs(player_pairs, connecting_pairs, ignore_pairs, win_func) do
  	all_possible_connecting_pairs = calc_conn_pairs(connecting_pairs)
  	new_conn_pairs = player_pairs -- (player_pairs -- all_possible_connecting_pairs)
  	ignore_pairs = ignore_pairs ++ connecting_pairs
  	new_conn_pairs = new_conn_pairs -- ignore_pairs

  	#if at least one of the connecting pairs (which means we found a connection of stones("X" or "O") from
  	#the starting position to here) satisfies win_func it means that current player won
  	if Enum.any?(new_conn_pairs, fn({x, y}) -> win_func.(x, y, 0) end) do
  		true
  	else
  		find_connecting_pairs(player_pairs, new_conn_pairs, ignore_pairs, win_func)
  	end
  end

  defp calc_conn_pairs([]), do: []
  defp calc_conn_pairs([{x, y} | other_connecting_pairs]) do
  	[  {x - 1, y},
       {x - 1, y + 1},
       {x, y + 1},
       {x, y - 1},
       {x + 1, y},
       {x + 1, y - 1}
      ] ++ calc_conn_pairs(other_connecting_pairs) #could be multiple connecting pairs, so check for all
  end

end
