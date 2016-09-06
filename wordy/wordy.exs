defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
  	answer_question(question, 0)
  end

  defp answer_question("", result), do: result
  defp answer_question(question, result) do
  	{question, result} = 
	  	cond do 
	  		Regex.match?(~r/What is [-]?[0-9]+ plus [-]?[0-9]+/, question) -> do_operation(question, "plus", &Kernel.+/2)
	  		Regex.match?(~r/What is [-]?[0-9]+ minus [-]?[0-9]+/, question) -> do_operation(question, "minus", &Kernel.-/2)
	  		Regex.match?(~r/What is [-]?[0-9]+ multiplied by [-]?[0-9]+/, question) -> do_operation(question, "multiplied by", &Kernel.*/2)
	  		Regex.match?(~r/What is [-]?[0-9]+ divided by [-]?[0-9]+/, question) -> do_operation(question, "divided by", &Kernel.div/2)
	  		Regex.match?(~r/^What is [-]?[0-9]+\?$/, question) -> {"", result}
	  		true -> raise ArgumentError
	  	end
  	answer_question(question, result)
  end

  defp do_operation(question, str_operation, operation_fun) do
    str_regex = "[-]?[0-9]+ " <> str_operation <> " [-]?[0-9]+"
    {:ok, pattern} = Regex.compile(str_regex)
    [[formula | _]] = Regex.scan(pattern, question)
    [[str_num1], [str_num2] | _] = Regex.scan(~r/[-]?[0-9]+/, formula)

    calculate(str_num1, str_num2, operation_fun, question, formula)
  end

  defp calculate(str_num1, str_num2, operation_fun, question, formula) do
    result = operation_fun.(String.to_integer(str_num1), String.to_integer(str_num2))
    question_with_new_result = String.replace(question, formula, Integer.to_string(result), global: false)
    {question_with_new_result, result}
  end

end
