defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
  	do_transform(Map.keys(input), input, %{})
  end

  defp do_transform([key | other_keys], input_map, transformed_map) do
  	values = Map.fetch!(input_map, key)
  	transformed_map = Enum.reduce(values, transformed_map, fn (val, acc) -> Map.put(acc, String.downcase(val), key) end)
  	do_transform(other_keys, input_map, transformed_map)
  end

  defp do_transform([], _input_map, transformed_map), do: transformed_map
end
