defmodule StacktraceCleanerTest do
  use ExUnit.Case
  doctest StacktraceCleaner

  test "current_stacktrace" do
    assert StacktraceCleaner.current_stacktrace() ==
             {StacktraceCleaner, :current_stacktraces, 1,
              [file: 'lib/stacktrace_cleaner.ex', line: 26]}

    assert StacktraceCleaner.current_stacktrace("test") ==
             {StacktraceCleanerTest, :"test current_stacktrace", 1,
              [file: 'test/stacktrace_cleaner_test.exs', line: 10]}
  end

  test "current_stacktraces" do
    assert StacktraceCleaner.current_stacktraces() == [
             {StacktraceCleaner, :current_stacktraces, 1,
              [file: 'lib/stacktrace_cleaner.ex', line: 26]},
             {StacktraceCleanerTest, :"test current_stacktraces", 1,
              [file: 'test/stacktrace_cleaner_test.exs', line: 16]}
           ]

    assert StacktraceCleaner.current_stacktraces("test") == [
             {StacktraceCleanerTest, :"test current_stacktraces", 1,
              [file: 'test/stacktrace_cleaner_test.exs', line: 23]}
           ]
  end

  test "clean" do
    stacktraces = Process.info(self(), :current_stacktrace) |> elem(1)

    assert StacktraceCleaner.clean(stacktraces) == [
             {StacktraceCleanerTest, :"test clean", 1,
              [file: 'test/stacktrace_cleaner_test.exs', line: 30]}
           ]

    assert StacktraceCleaner.clean(stacktraces, "lib") == []
  end
end
