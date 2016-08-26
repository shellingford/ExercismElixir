defmodule Bob do
  def hey(input) do
    cond do
        Regex.match?(~r/^.*[?]$/, input) -> "Sure."
        Regex.match?(~r/^.*\p{Lu}.*$/u, input) and not Regex.match?(~r/^.*\p{Ll}.*$/u, input) -> "Whoa, chill out!"
        String.length(String.strip(input)) == 0 -> "Fine. Be that way!"
        true -> "Whatever."
    end
  end
end
