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

  @doc """
  This function retrieves a sequential history of the the sums computed by the `Fibonacci` GenServer
  """
  @spec history :: {:ok, list(tuple())}
  def history do
    GenServer.call(@name, :history)
  end

  # Server Callbacks

  @doc false
  @spec init(term()) :: {:ok, map()}
  def init(_stack) do
    {:ok, %{history: [], sums: %{}}}
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
        |> calculate_sum(state.sums)
      end)

    {:reply, {:ok, totals}, state}
  end

  def handle_call({:calculate, num}, _from, state) do
    total =
      num
      |> calculate_sum(state.sums)

    {:reply, {:ok, total}, state}
  end

  @doc """
  This call back retrieves the caluculation history at a particular time
  """
  @spec handle_call(:history, pid(), map()) :: {:ok, list(tuple())}
  def handle_call(:history, _from, %{history: history} = state) do
    {:reply, {:ok, history}, state}
  end

  @doc """
  This callback handles the process number message by pushing on to the calculation history and caching the sum of a
  numbers sequence
  """
  @spec handle_info({:process_number, integer(), integer()}, map()) :: {:noreply, map()}
  def handle_info({:process_number, num, total}, state) do
    reversed_history = Enum.reverse(state.history)

    intermediate_history = [{num, total} | reversed_history]

    actual_history = Enum.reverse(intermediate_history)

    new_sums =
      case Map.has_key?(state.sums, num) do
        true -> state.sums
        false -> Map.put(state.sums, num, total)
      end

    {:noreply, %{state | history: actual_history, sums: new_sums}}
  end

  @doc false
  @spec calculate_sum(integer(), map()) :: integer()
  defp calculate_sum(num, sums) do
    total =
      case Map.has_key?(sums, num) do
        true ->
          Map.get(sums, num)

        false ->
          num
          |> Sequencer.find()
          |> Enum.sum()
      end

    Process.send(@name, {:process_number, num, total}, [])

    total
  end
end
