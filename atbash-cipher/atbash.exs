defmodule Atbash do
	require Logger
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
  	letters = ?a..?z
  	reverse_letters = ?z..?a
  	numbers = ?0..?9

  	encoded_string = plaintext
  		|> String.downcase
  		|> String.to_charlist
  		|> Enum.filter(fn(c) -> c in letters or c in numbers end)
  		|> Enum.map(fn(c) -> if c in letters do Enum.at(reverse_letters, c - 97) else c end end)
  		|> String.Chars.to_string

    chunks = Regex.scan(~r(.{1,5}), encoded_string)
    Enum.join(chunks, " ")
  end

end
