defmodule BracketPush do
	require Logger
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
  	do_checking(String.graphemes(str), [])
  end

  defp do_checking([char | other_chars], []) do
  	if (is_bracket(char)) do
  		bracket_list = [char]
  		do_checking(other_chars, bracket_list)
  	else
  		do_checking(other_chars, [])
  	end
  end

  defp do_checking([char | other_chars], brackets) do
  	#if character is a bracket, process it, otherwise ignore it
  	if (is_bracket(char)) do
		  last_bracket = List.last(brackets)
  		cond do
  			is_opening_bracket(char) -> process_opening_bracket(last_bracket, brackets, char, other_chars)
  			is_closing_bracket(char) -> process_closing_bracket(last_bracket, brackets, char, other_chars)
  		end
  	else
  		do_checking(other_chars, brackets)
  	end
  end

  defp do_checking([], []), do: true
  defp do_checking([], _brackets), do: false

  defp process_opening_bracket(last_bracket, brackets, char, other_chars) do 
    if (is_opening_bracket(last_bracket)) do
        brackets = brackets ++ [char]
        do_checking(other_chars, brackets)
    else
      false
    end
  end

  defp process_closing_bracket(last_bracket, brackets, char, other_chars) do 
    if (check_bracket_pair(last_bracket, char)) do
      brackets = Enum.reverse(Enum.reverse(brackets) -- [last_bracket])
      do_checking(other_chars, brackets)
    else
      false
    end
  end

  defp is_bracket(char) do
  	is_opening_bracket(char) or is_closing_bracket(char)
  end

  defp is_opening_bracket(char) do
  	char == "[" or char == "(" or char == "{" or char == "<"
  end

  defp is_closing_bracket(char) do
  	char == "]" or char == ")" or char == "}" or char == ">"
  end

  defp check_bracket_pair(opening_bracket, closing_bracket) do
  	opening_bracket == "[" and closing_bracket == "]" or
  	opening_bracket == "{" and closing_bracket == "}" or
  	opening_bracket == "(" and closing_bracket == ")" or
  	opening_bracket == "<" and closing_bracket == ">"
  end

end
