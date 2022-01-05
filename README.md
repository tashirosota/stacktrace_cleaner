<!-- @format -->

[![hex.pm version](https://img.shields.io/hexpm/v/ltsv.svg)](https://hex.pm/packages/stacktrace_cleaner)
[![CI](https://github.com/tashirosota/stacktrace_cleaner/actions/workflows/ci.yml/badge.svg)](https://github.com/tashirosota/stacktrace_cleaner/actions/workflows/ci.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/tashirosota/stacktrace_cleaner)

# StacktraceCleaner

Stacktraces often include many lines that are not relevant for the context under review.
This makes it hard to find the signal amongst many noise, and adds debugging time.
StacktraceCleaner is a module to remove those noises and make them easier to see.
Inspired by [`ActiveSupport::BacktraceCleaner`](https://github.com/rails/rails/blob/main/activesupport/lib/active_support/backtrace_cleaner.rb)

## Installation

```elixir
def deps do
  [
    {:stacktrace_cleaner, "~> 0.1.1"}
  ]
end
```

## Usage

**[docs](https://hexdocs.pm/stacktrace_cleaner)**

```elixir
iex(1)> StacktraceCleaner.current_stacktrace
{StacktraceCleaner, :current_stacktraces, 1, [file: 'lib/stacktrace_cleaner.ex', line: 26]}
iex(2)> StacktraceCleaner.current_stacktraces
[
  {StacktraceCleaner, :current_stacktraces, 1,
  [file: 'lib/stacktrace_cleaner.ex', line: 26]},
  {StacktraceCleanerTest, :"test current_stacktraces", 1,
  [file: 'test/stacktrace_cleaner_test.exs', line: 16]}
]
iex(3)> StacktraceCleaner.clean(stacktraces)
[
  {StacktraceCleanerTest, :"test clean", 1,
  [file: 'test/stacktrace_cleaner_test.exs', line: 30]}
]
iex(4)> try do
...(4)>   raise "Oh no!"
...(4)> rescue
...(4)>   e in RuntimeError -> __STACKTRACE__ |> StacktraceCleaner.clean |> IO.inspect
...(4)> end
[
  {StacktraceCleanerTest, :"test ", 1,
   [
     file: 'test/stacktrace_cleaner_test.exs',
     line: 42,
     error_info: %{module: Exception}
   ]}
]
```
