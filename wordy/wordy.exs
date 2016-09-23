defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
    question
      |> question_to_list
      |> calculate
  end

  defp question_to_list(question) do
    question
      |> String.replace_leading("What is ", "")
      |> String.replace_trailing("?", "")
      |> String.split(" ")
  end

  defp calculate([str_num1, "plus", str_num2 | rest]) do
    str_result = Integer.to_string(String.to_integer(str_num1) + String.to_integer(str_num2))
    calculate([str_result | rest])
  end

  defp calculate([str_num1, "minus", str_num2 | rest]) do
    str_result = Integer.to_string(String.to_integer(str_num1) - String.to_integer(str_num2))
    calculate([str_result | rest])
  end

  defp calculate([str_num1, "multiplied", "by", str_num2 | rest]) do
    str_result = Integer.to_string(String.to_integer(str_num1) * String.to_integer(str_num2))
    calculate([str_result | rest])
  end

  defp calculate([str_num1, "divided", "by", str_num2 | rest]) do
    str_result = Integer.to_string(div(String.to_integer(str_num1), String.to_integer(str_num2)))
    calculate([str_result | rest])
  end

  defp calculate([str_result]), do: String.to_integer(str_result)
  defp calculate(_list), do: raise ArgumentError
end
