defmodule FibonacciTest do
  @moduledoc """
  This module holds unit and integration tests for our Fibonacci Server
  """
  use ExUnit.Case

  describe "Fibonacci tests" do
    test "calculate/1 returns correct results for single number" do
      assert {:ok, 0} = Fibonacci.calculate(0)

      assert {:ok, 4} = Fibonacci.calculate(3)
    end
  end
end
