defmodule SisCrawler.MixProject do
  use Mix.Project

  def project do
    [
      app: :sis_crawler,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SisCrawler.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:jason, "~> 1.1"},
      {:floki, "~> 0.20"},
      {:html5ever, "~> 0.7.0"},
      {:gen_stage, "~> 0.11"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
    ]
  end
end
