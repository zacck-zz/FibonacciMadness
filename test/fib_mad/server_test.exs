defmodule FibonacciTest do
  @moduledoc """
  This module holds unit and integration tests for our Fibonacci Server
  """
  use ExUnit.Case

  # capture log when testing
  @moduletag capture_log: true

  # restart application to ensure state is fresh for testing
  setup do
    Application.stop(:fib_mad)
    Application.start(:fib_mad)

    :ok
  end

  describe "Fibonacci tests" do
    test "calculate/1 returns correct results for single number" do
      assert {:ok, 0} = Fibonacci.calculate(0)

      assert {:ok, 4} = Fibonacci.calculate(3)
    end

    test "calculate/1 returns correct results for a list of numbers" do
      assert {:ok, [0, 4]} = Fibonacci.calculate([0, 3])
    end

    test "server stores ordered history of calculations" do
      Fibonacci.calculate(0)

      Fibonacci.calculate(3)

      Fibonacci.calculate(0)

      assert {:ok, [{0, 0}, {3, 4}, {0, 0}]} = Fibonacci.history()
    end
  end
end
