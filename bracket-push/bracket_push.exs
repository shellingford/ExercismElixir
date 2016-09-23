defmodule BracketPush do
	require Logger
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    Regex.scan(~r/[\[\]\(\)\{\}<>]/, str)
      |> List.flatten
      |> do_checking([])
  end

  defp do_checking([current_bracket | other_brackets], []) do
  	bracket_list = [current_bracket]
    do_checking(other_brackets, bracket_list)
  end

  defp do_checking([current_bracket | other_brackets], brackets) when current_bracket in ["[", "(", "{", "<"],
    do: do_checking(other_brackets, [current_bracket | brackets])

  defp do_checking([current_bracket | other_brackets], [prev_bracket | brackets]) when current_bracket in ["]", ")", "}", ">"] do
    if (valid_bracket_pair?(prev_bracket, current_bracket)) do
      do_checking(other_brackets, brackets)
    else
      false
    end
  end

  defp do_checking([], []), do: true
  defp do_checking([], _brackets), do: false

  defp valid_bracket_pair?(opening_bracket, closing_bracket),
    do: {opening_bracket, closing_bracket} in [{"[","]"}, {"{","}"}, {"(",")"}, {"<",">"}] 
end
