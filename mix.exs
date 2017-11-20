defmodule FunFunc.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fun_func,
      version: "0.1.0",
      elixir: "~> 1.5",
      name: "FunFunc",
      description: description(),
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
    ]
  end

  def description do
    "Fun Functions for general purpose."
  end

  def package do
    [
      maintainers: ["techno-tanoC"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/techno-tanoC/fun_func"},
    ]
  end

  def application do
    [
      extra_applications: [:logger],
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev},
    ]
  end
end
