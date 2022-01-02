defmodule StacktraceCleaner do
  @moduledoc """
  Stacktraces often include many lines that are not relevant for the context under review.
  This makes it hard to find the signal amongst many noise, and adds debugging time.
  StacktraceCleaner is a module to remove those noises and make them easier to see.
  """
  @noise_paths ["process", "ex_unit", ".erl"]
  @type t :: {atom(), atom(), integer, [file: charlist(), line: integer()]}

  @doc """
  Extracts first stacktrace from `StacktraceCleaner.current_stacktraces`
    * match_path: If you want to extract more strictly, you can specify it with an argument.
  """
  @spec current_stacktrace(String.t() | nil) :: t
  def current_stacktrace(match_path \\ nil) do
    [stacktrace | _] = current_stacktraces(match_path)
    stacktrace
  end

  @doc """
  Gets cleaned stacktraces.
    * match_path: If you want to extract more strictly, you can specify it with an argument.
  """
  @spec current_stacktraces(String.t() | nil) :: list(t)
  def current_stacktraces(match_path \\ nil) do
    Process.info(self(), :current_stacktrace)
    |> elem(1)
    |> clean(match_path)
  end

  @doc """
  Cleans stacktraces.
    * match_path: If you want to extract more strictly, you can specify it with an argument.
  """
  @spec clean(list(t), String.t() | nil) :: list(t)
  def clean(stacktraces, match_path \\ nil) do
    deps_app_regexes = create_deps_app_regexes()

    cleaned =
      stacktraces
      |> Enum.reject(fn stacktrace ->
        stacktrace_path = stacktrace |> elem(3) |> Keyword.get(:file) |> to_string()
        deps_app_regexes |> Enum.find(&(stacktrace_path =~ &1))
      end)

    if match_path do
      cleaned
      |> Enum.filter(fn stacktrace ->
        stacktrace |> elem(3) |> Keyword.get(:file) |> to_string() =~ Regex.compile!(match_path)
      end)
    else
      cleaned
    end
  end

  defp create_deps_app_regexes do
    (Mix.Project.deps_apps() ++ @noise_paths)
    |> Enum.filter(&(!is_nil(&1)))
    |> Enum.map(fn app ->
      app
      |> to_string()
      |> Regex.compile!()
    end)
  end
end
