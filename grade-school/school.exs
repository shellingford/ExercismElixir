defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    db = 
      if (Map.has_key?(db, grade)) do
        {students, _} = Map.pop(db, grade)
        students = students ++ [name]
        Map.put(db, grade, students)
      else
        Map.put(db, grade, [name])
      end
    db
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    if (Map.has_key?(db, grade)) do
      Map.fetch!(db, grade)
    else
      []
    end
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    db_sorted_keys = Enum.sort(db)
    sort_list_values(db_sorted_keys)
  end

  defp sort_list_values([first_value | list_values]) do
    {key, students} = first_value
    students = Enum.sort(students)
    [{key, students} | sort_list_values(list_values)]
  end

  defp sort_list_values([]), do: []
end
