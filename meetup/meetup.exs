defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    first_day_of_month = :calendar.day_of_the_week(year, month, 1)
    day_of_month = 1
    wday_num = weekday_as_num(weekday)

    #set date to correct weekday
    day_of_month = day_of_month |> calculate_date_of_month(first_day_of_month, wday_num)

    #shift date to correct week of the month
    {year, month, find_correct_day_of_month(day_of_month, wday_num, year, month, schedule)}
  end

  defp calculate_date_of_month(day_of_month, first_day_of_month, wday_num) when first_day_of_month > wday_num,
    do: day_of_month + 7 - first_day_of_month + wday_num
  defp calculate_date_of_month(day_of_month, first_day_of_month, wday_num) when first_day_of_month < wday_num,
    do: day_of_month + wday_num - first_day_of_month
  defp calculate_date_of_month(day_of_month, first_day_of_month, wday_num) when first_day_of_month == wday_num,
    do: day_of_month

  defp weekday_as_num(:monday), do: 1
  defp weekday_as_num(:tuesday), do: 2
  defp weekday_as_num(:wednesday), do: 3
  defp weekday_as_num(:thursday), do: 4
  defp weekday_as_num(:friday), do: 5
  defp weekday_as_num(:saturday), do: 6
  defp weekday_as_num(:sunday), do: 7

  defp find_correct_day_of_month(day_of_month, _wday_num, _year, _month, :first) do
    day_of_month
  end

  defp find_correct_day_of_month(day_of_month, _wday_num, _year, _month, :second) do
    day_of_month + 7
  end

  defp find_correct_day_of_month(day_of_month, _wday_num, _year, _month, :third) do
    day_of_month + 14
  end

  defp find_correct_day_of_month(day_of_month, _wday_num, _year, _month, :fourth) do
    day_of_month + 21
  end

  defp find_correct_day_of_month(_day_of_month, wday_num, year, month, :last) do
    find_last_of_month(wday_num, year, month)
  end

  defp find_correct_day_of_month(day_of_month, _wday_num, year, month, :teenth) do
    find_teenth_of_month(day_of_month + 7, year, month)
  end

  defp find_last_of_month(wday_num, year, month) do
    last_day_of_month = :calendar.last_day_of_the_month(year, month)
    wday_last_day = :calendar.day_of_the_week(year, month, last_day_of_month)

    cond do
      wday_last_day > wday_num -> last_day_of_month - (wday_last_day - wday_num)
      wday_last_day < wday_num -> last_day_of_month - (7 - wday_num + wday_last_day)
      true -> last_day_of_month
    end
  end

  defp find_teenth_of_month(day_of_month, _year, _month) when day_of_month > 12 and day_of_month < 21, do: day_of_month
  defp find_teenth_of_month(day_of_month, year, month), do: find_teenth_of_month(day_of_month + 7, year, month)

end
