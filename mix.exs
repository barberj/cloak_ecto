defmodule Cloak.Ecto.MixProject do
  use Mix.Project

  def project do
    [
      app: :cloak_ecto,
      version: "1.0.0-alpha.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      source_url: "https://github.com/danielberkompas/cloak_ecto",
      description: "Encrypted fields for Ecto",
      deps: deps(),
      docs: docs(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cloak, github: "danielberkompas/cloak"},
      {:ecto, "~> 3.0.0"},
      {:flow, "~> 0.14"},
      {:pbkdf2, "~> 2.0", optional: true},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, ">= 0.0.0", only: :test},
      {:ecto_sql, ">= 0.0.0", only: [:dev, :test]},
      {:postgrex, ">= 0.0.0", only: [:dev, :test]},
      {:jason, ">= 0.0.0", only: [:dev, :test]},
      {:inch_ex, github: "rrrene/inch_ex", only: :test}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md",
        "guides/how_to/install.md": [title: "Install Cloak"],
        "guides/how_to/generate_keys.md": [title: "Generate Encryption Keys"],
        "guides/how_to/encrypt_existing_data.md": [title: "Encrypt Existing Data"],
        "guides/how_to/rotate_keys.md": [title: "Rotate Keys"]
      ],
      extra_section: "GUIDES",
      groups_for_extras: [
        "How To": ~r/how_to/
      ],
      groups_for_modules: [
        Behaviours: [
          Cloak.Ecto.CustomCursor
        ],
        "Ecto Types": ~r/Fields/
      ]
    ]
  end

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
