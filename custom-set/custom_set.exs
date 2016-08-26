defmodule CustomSet do

  defstruct list: []

  def new(enumerable) do
    list_as_set = enumerable |> Enum.uniq |> Enum.sort
    %CustomSet{list: list_as_set}
  end

  def empty?(%CustomSet{list: []}), do: true
  def empty?(%CustomSet{list: _list}), do: false

  def contains?(%CustomSet{list: list}, element) do
    Enum.any?(list, fn(x) -> x == element end)
  end

  def subset?(%CustomSet{list: []}, %CustomSet{list: []}), do: true
  def subset?(%CustomSet{list: []}, %CustomSet{list: _list}), do: true
  def subset?(%CustomSet{list: _list}, %CustomSet{list: []}), do: false
  def subset?(%CustomSet{list: list1}, %CustomSet{list: list2}) when length(list1) > length(list2), do: false
  def subset?(%CustomSet{list: list1}, %CustomSet{list: list2}), do: list1 == list2 -- (list2 -- list1)

  def disjoint?(%CustomSet{list: []}, %CustomSet{list: []}), do: true
  def disjoint?(%CustomSet{list: []}, %CustomSet{list: _list}), do: true
  def disjoint?(%CustomSet{list: _list}, %CustomSet{list: []}), do: true
  def disjoint?(%CustomSet{list: list1}, %CustomSet{list: list2}), do: [] == list2 -- (list2 -- list1)

  def equal?(%CustomSet{list: []}, %CustomSet{list: []}), do: true
  def equal?(%CustomSet{list: []}, %CustomSet{list: _list}), do: false
  def equal?(%CustomSet{list: _list}, %CustomSet{list: []}), do: false
  def equal?(%CustomSet{list: list1}, %CustomSet{list: list2}), do: list1 == list2

  def add(%CustomSet{list: list}, element) do
    list = list ++ [element]
    new(list)
  end

  def intersection(%CustomSet{list: []}, %CustomSet{list: []}), do: new([])
  def intersection(%CustomSet{list: []}, %CustomSet{list: _list}), do: new([])
  def intersection(%CustomSet{list: _list}, %CustomSet{list: []}), do: new([])
  def intersection(%CustomSet{list: list1}, %CustomSet{list: list2}), do: new(list2 -- (list2 -- list1))

  def difference(%CustomSet{list: []}, %CustomSet{list: []}), do: new([])
  def difference(%CustomSet{list: []}, %CustomSet{list: _list}), do: new([])
  def difference(%CustomSet{list: list}, %CustomSet{list: []}), do: new(list)
  def difference(%CustomSet{list: list1}, %CustomSet{list: list2}), do: new(list1 -- list2)

  def union(%CustomSet{list: []}, %CustomSet{list: []}), do: new([])
  def union(%CustomSet{list: []}, %CustomSet{list: list}), do: new(list)
  def union(%CustomSet{list: list}, %CustomSet{list: []}), do: new(list)
  def union(%CustomSet{list: list1}, %CustomSet{list: list2}), do: new(list1 ++ list2)

end
