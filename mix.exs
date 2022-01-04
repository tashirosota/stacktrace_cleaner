defmodule StacktraceCleaner.MixProject do
  use Mix.Project
  @versoin "0.1.1"
  @source_url "https://github.com/tashirosota/stacktrace_cleaner"
  @description "Reduces and eliminates stacktraces noise, can get clean stack traces."
  def project do
    [
      app: :stacktrace_cleaner,
      version: @versoin,
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: @description,
      name: "StacktraceCleaner",
      package: package(),
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package() do
    [
      licenses: ["Apache-2.0"],
      maintainers: ["Sota Tashiro"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp deps() do
    [{:ex_doc, ">= 0.0.0", only: :dev, runtime: false}]
  end
end
