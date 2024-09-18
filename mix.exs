defmodule WandererApp.MixProject do
  use Mix.Project

  @source_url "https://github.com/wanderer-industries/wanderer"
  @version "1.0.2"

  def project do
    [
      app: :wanderer_app,
      version: @version,
      elixir: "~> 1.16",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      source_url: @source_url,
      releases: [
        wanderer_app: [
          include_executables_for: [:unix],
          steps: [:assemble, :tar],
          applications: [
            wanderer_app: :permanent
          ],
          version: "1.0.0"
        ]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {WandererApp.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false},
      {:doctor, ">= 0.0.0", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false},
      {:sobelow, ">= 0.0.0", only: [:dev], runtime: false},
      {:mix_audit, ">= 0.0.0", only: [:dev], runtime: false},
      {:ex_check, "~> 0.14.0", only: [:dev], runtime: false},
      {:phoenix, "~> 1.7.12"},
      {:phoenix_ecto, "~> 4.6"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_live_reload, "~> 1.5.3", only: :dev},
      {:phoenix_live_view, "~> 0.20.17"},
      {:phoenix_pubsub, "~> 2.1"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:phoenix_ddos, "~> 1.1"},
      {:tailwind, "~> 0.2.2", runtime: Mix.env() == :dev},
      {:heroicons, "~> 0.5.5"},
      {:swoosh, "~> 1.3"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 1.0", override: true},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.4"},
      {:dns_cluster, "~> 0.1.1"},
      {:plug_cowboy, "~> 2.5"},
      {:plug_dynamic, "~> 1.0"},
      {:plug_content_security_policy, "~> 0.2.1"},
      {:dart_sass, "~> 0.5.1", runtime: Mix.env() == :dev},
      {:oauth2, "~> 1.0 or ~> 2.0"},
      {:ueberauth, "~> 0.10.0"},
      {:req, "~> 0.4.0"},
      {:ash, "~> 3.4"},
      {:ash_cloak, "~> 0.1.2"},
      {:ash_phoenix, "~> 2.1"},
      {:ash_postgres, "~> 2.4"},
      {:exsync, "~> 0.4", only: :dev},
      {:nimble_csv, "~> 1.2.0"},
      {:cachex, "~> 3.6"},
      {:live_select, "~> 1.4"},
      {:nebulex, "~> 2.6"},
      {:decorator, "~> 1.4"},
      {:slugify, "~> 1.3"},
      {:debounce_and_throttle, "~> 0.9.0"},
      {:ex2ms, "~> 1.0"},
      {:merkle_map, "~> 0.2.1"},
      {:prom_ex, "~> 1.9"},
      {:fresh, "~> 0.4.4"},
      {:nimble_publisher, "~> 1.0"},
      {:makeup_elixir, ">= 0.0.0"},
      {:makeup_erlang, ">= 0.0.0"},
      {:better_number, "~> 1.0.0"},
      {:delta_crdt, "~> 0.6.5"},
      {:qex, "~> 0.5"},
      {:site_encrypt, "~> 0.6.0"},
      {:bandit, "~> 1.0"},
      {:uuid, "~> 1.1"},
      {:cloak, "1.1.4"},
      {:quantum, "~> 3.0"},
      {:pathex, "~> 2.5"},
      {:mox, "~> 1.1", only: [:test, :integration]},
      {:git_ops, "~> 2.6.1"},
      {:version_tasks, "~> 0.12.0"},
      {:error_tracker, "~> 0.2"},
      {:sourceror, "~> 1.3.0", override: true}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": [
        "cmd npm install --prefix assets"
      ],
      "assets.build": [],
      "assets.deploy": [
        "assets.setup",
        "cmd --cd assets npm run build",
        "phx.digest"
      ]
    ]
  end
end