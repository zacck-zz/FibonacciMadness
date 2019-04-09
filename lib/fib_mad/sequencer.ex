defmodule FibMad.Sequencer do
  @moduledoc """
  This module hold the logic to build the fibonacci sequnce for a given number N 
  """

  @doc """
  This function takes a non negative integer and calculates the fibonacci sequence for that integer
  """
  @spec find(non_neg_integer()) :: nonempty_list(integer())
  def find(nth) do
    list = [1, 1]
    fib(list, nth)
  end

  @doc false
  @spec fib(nonempty_list(non_neg_integer()), non_neg_integer()) ::
          nonempty_list(non_neg_integer())
  defp fib(list, int)

  defp fib(_list, 0), do: [0]

  defp fib(_list, 1), do: [1]

  defp fib(list, 2) do
    Enum.reverse(list)
  end

  defp fib(list, n) do
    fib([hd(list) + hd(tl(list))] ++ list, n - 1)
  end
end
