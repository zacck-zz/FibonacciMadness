defmodule FibMad.SequencerTest do
  @moduledoc """
  Tests for our Fibonacci Sequencer 
  """
  use ExUnit.Case
  alias FibMad.Sequencer

  describe "sequencer tests" do
    test "returns correct list for 0 as input" do
      assert [0] = Sequencer.find(0)
    end

    test "returns correct list for 1 as input" do
      assert [1] = Sequencer.find(1)
    end

    test "retunrs correct list for non edge case input" do
      assert [1, 1, 2] = Sequencer.find(3)
    end
  end
end
