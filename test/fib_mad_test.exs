defmodule FibMadTest do
  use ExUnit.Case
  doctest FibMad

  test "greets the world" do
    assert FibMad.hello() == :world
  end
end
