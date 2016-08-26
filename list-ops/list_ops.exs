defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end

  defp do_count([], count) do
    count
  end

  defp do_count([_first_element | other_elements], count) do
    do_count(other_elements, count + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([], []) do
    []
  end

  defp do_reverse([], reverse_list) do
    reverse_list
  end

  defp do_reverse([first_element | other_elements], []) do
    do_reverse(other_elements, [first_element])
  end

  defp do_reverse([first_element | other_elements], reverse_list) do
    do_reverse(other_elements, [first_element | reverse_list])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f)
  end

  defp do_map([first_element | other_elements], f) do
    [f.(first_element) | do_map(other_elements, f)]
  end

  defp do_map([], _f) do
    []
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f)
  end

  defp do_filter([first_element | other_elements], f) do
    if (f.(first_element) == true) do
      [first_element | do_filter(other_elements, f)]
    else
      do_filter(other_elements, f)
    end
  end

  defp do_filter([], _f) do
    []
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    do_reduce(l, acc, f)
  end

  defp do_reduce([first_element | other_elements], acc, f) do
    acc = f.(first_element, acc)
    do_reduce(other_elements, acc, f)
  end

  defp do_reduce([], acc, _f) do
    acc
  end

  @spec append(list, list) :: list
  def append(a, b) do
    do_append(a, b)
  end

  defp do_append([], []) do
    []
  end

  defp do_append(a, []) do
    a
  end

  defp do_append([], b) do
    b
  end

  defp do_append([first_element | other_elements], b) do
    [first_element | do_append(other_elements, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    do_concat(ll)
  end

  defp do_concat([head | tail]) do
    head_list = 
    if is_list(head) do
      head_list = extract_lists(head)
    else
      head_list = head
    end

    tail_list = 
    if is_list(tail) do
      tail_list = extract_lists(tail)
    else
      tail_list = tail
    end

    append(head_list, tail_list)
  end

  defp do_concat([]) do
    []
  end

  defp do_concat(elem) do
    elem
  end

  defp extract_lists([head | tail]) do
    if is_list(head) do
      append(extract_lists(head), extract_lists(tail))
    else
      [head | extract_lists(tail)]
    end
  end

  defp extract_lists(elem) do
    elem
  end

end
