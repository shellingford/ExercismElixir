defmodule Gigasecond do
	require Logger
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from({date, time}) do
  	sec = :calendar.datetime_to_gregorian_seconds({date, time})
  	sec = sec + 1_000_000_000
  	:calendar.gregorian_seconds_to_datetime(sec)
  end
end
