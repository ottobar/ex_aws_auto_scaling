defmodule ExAws.AutoScaling.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aws_auto_scaling,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_aws, "~> 2.0"},
      {:hackney, "~> 1.15", only: [:dev, :test]},
      {:poison, "~> 3.1", only: [:dev, :test]},
      {:sweet_xml, "~> 0.6", only: [:dev, :test]}
    ]
  end
end
