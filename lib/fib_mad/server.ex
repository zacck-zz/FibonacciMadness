defmodule Fibonacci do
  @moduledoc """
  This modules holds the implementation for our GenServer that is in charge of calculating sums, caching sum results 
  and in addition maintains a sum calculation history
  """
  use GenServer

  @name :fib

  alias FibMad.Sequencer

  # Client
  @doc """
  This 1 arity function starts our Fibonacci server in charge of sums calculation and sum caching
  """
  @spec start_link(term()) :: {:ok, pid()}
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  @doc """
  This function accepts a number or a list of numbers and proceeds to calculate the number(s) fibonacci totals 
  then responds with a tuple containing the results of the calculations
  """
  @spec calculate(integer()) :: {:ok, term()}
  def calculate(num) do
    GenServer.call(@name, {:calculate, num})
  end

  # Server Callbacks

  @doc false
  @spec init(term()) :: {:ok, map()}
  def init(_stack) do
    {:ok, %{}}
  end

  @doc """
  This callback handles calculating results for a given number, it users the sequencer to generate a Fibonacci sequence for 
  a given number and then calculates and returns the sum of that sequence
  """
  @spec handle_call({:calculate, integer()}, pid(), map()) :: {:reply, {:ok, term()}, map()}
  def handle_call(tuple, from, state)

  def handle_call({:calculate, nums}, _from, state) when is_list(nums) do
    totals =
      Enum.map(nums, fn num ->
        num
        |> Sequencer.find()
        |> Enum.sum()
      end)

    {:reply, {:ok, totals}, state}
  end

  def handle_call({:calculate, num}, _from, state) do
    total =
      num
      |> Sequencer.find()
      |> Enum.sum()

    {:reply, {:ok, total}, state}
  end
end
