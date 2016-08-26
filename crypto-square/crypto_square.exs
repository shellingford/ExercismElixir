defmodule CryptoSquare do
	require Logger
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""

  def encode(str) do
  	normalized = normalize_string(str)
  	chunks = create_chunks(normalized)
  	encode_chunks(chunks)
  end

  defp normalize_string(str) do
  	letters = ?a..?z
  	numbers = ?0..?9
  	str
  		|> String.downcase
  		|> String.to_charlist
  		|> Enum.filter(fn(c) -> c in letters or c in numbers end)
  end

  defp create_chunks(str) do
  	chunk_size = :math.sqrt(length(str)) |> Float.ceil |> trunc
  	Enum.chunk(str, chunk_size, chunk_size, Stream.repeatedly(fn -> '' end))
  end

  defp encode_chunks(chunks) do
  	chunks
  		|> List.zip
  		|> Enum.map_join(" ", &Tuple.to_list/1)
  end

end
