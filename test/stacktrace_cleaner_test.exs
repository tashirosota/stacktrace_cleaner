defmodule StacktraceCleanerTest do
  use ExUnit.Case
  doctest StacktraceCleaner

  test "greets the world" do
    assert StacktraceCleaner.hello() == :world
  end
end
