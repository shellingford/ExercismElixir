defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) when number > 3 and number <= 100, do:
      "#{inspect (number - 1)} bottles of beer on the wall, #{inspect (number - 1)} bottles of beer.\n" <>
       "Take one down and pass it around, #{inspect (number - 2)} bottles of beer on the wall.\n"

  def verse(number) when number == 3, do:
      "2 bottles of beer on the wall, 2 bottles of beer.\n" <>
       "Take one down and pass it around, 1 bottle of beer on the wall.\n"

  def verse(number) when number == 2, do:
      "1 bottle of beer on the wall, 1 bottle of beer.\n" <>
       "Take it down and pass it around, no more bottles of beer on the wall.\n"

  def verse(number) when number == 1, do:
      "No more bottles of beer on the wall, no more bottles of beer.\n" <>
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"


  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 100..1) do
    get_lyrics(Enum.to_list(range))
  end

  defp get_lyrics([verse_number | range]) when verse_number > 1, do: verse(verse_number) <> "\n" <> get_lyrics(range)
  defp get_lyrics([verse_number | range]), do: verse(verse_number) <> get_lyrics(range)
  defp get_lyrics([]), do: ""
end
