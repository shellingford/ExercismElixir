defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, _workers) when length(texts) == 0, do: %{}

  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
  	pids = spawn_procs(workers)
  	start_workers(texts, pids)
  	map = collect_results(1..length(texts))
  	stop_procs(pids)
  	map
  end

  defp spawn_procs(workers) do
  	Enum.map(1..workers, &spawn_process/1)
  end

  defp spawn_process(_worker) do
  	parent = self()
  	spawn(fn -> proc_loop(parent) end)
  end

  defp proc_loop(parent) do
  	receive do
  		{:count_letters, text} -> 
  			send(parent, do_work(text))
  			proc_loop(parent)
		:stop -> nil #do nothing, just let proc stop
  	end
  end

  defp do_work(text) do
  	letter_groups = String.graphemes(remove_extra_chars(text))
  	count_letters(letter_groups, %{})
  end

  defp count_letters([letter | other_letters], map) do
  	map = Map.update(map, String.downcase(letter), 1, &(&1 + 1))
  	count_letters(other_letters, map)
  end

  defp count_letters([], map), do: map

  defp remove_extra_chars(text) do
    Regex.replace(~r/[\s\d,-]/, text, "")
  end

  defp start_workers(texts, pids) do
    workers = length(pids)
    text_with_index = Enum.with_index(texts)
    Enum.each(text_with_index, fn ({text, index}) ->
      send(Enum.at(pids, rem(index, workers)), {:count_letters, text})
    end)
  end

  defp collect_results(texts_size_range) do
  	result_list = Enum.map(texts_size_range, fn(_) -> receive do result -> result end end)
  	map = %{}
  	Enum.reduce(result_list, map, fn(result_map, map) -> Map.merge(map, result_map, fn _k, v1, v2 -> v1 + v2 end) end)
  end

  defp stop_procs(pids) do
  	Enum.each(pids, fn(pid) -> send(pid, :stop) end)
  end

end
