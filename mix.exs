defmodule Substrate.Mixfile do
  use Mix.Project

  @version "3.8.0"

  def project do
    [
      app: :substrate,
      version: @version,
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      consolidate_protocols: Mix.env() != :test,
      source_url: "https://github.com/juliusiv/substrate",
      homepage_url: "https://github.com/juliusiv/substrate",
      docs: [extras: ["README.md"], main: "readme", source_ref: "v#{@version}"],
      dialyzer: [
        plt_add_apps: [:mix, :jason, :poison],
        plt_add_deps: :apps_direct,
        flags: ["-Werror_handling", "-Wno_unused", "-Wunmatched_returns", "-Wunderspecs"],
        remove_defaults: [:unknown]
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application, do: [extra_applications: []]

  defp description() do
    "Annotate your API handlers from within their own file."
  end

  defp package() do
    [
      name: "open_api_spex",
      files: ["lib", "mix.exs", "README.md", "LICENSE", "CHANGELOG.md"],
      maintainers: [
        "Julius Alexander IV"
      ],
      licenses: ["Mozilla Public License, version 2.0"],
      links: %{"GitHub" => "https://github.com/juliusiv/substrate"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1", only: [:dev, :test]},
      {:jason, "~> 1.0", only: [:dev, :test]},
      {:plug, "~> 1.7"},
      {:phoenix, "~> 1.3", only: [:dev, :test]},
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false}
    ]
  end
end
