defmodule Dynamicgenservers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DynamicgenserversWeb.Telemetry,
      Dynamicgenservers.Repo,
      {DNSCluster, query: Application.get_env(:dynamicgenservers, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Dynamicgenservers.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Dynamicgenservers.Finch},
      # Start a worker by calling: Dynamicgenservers.Worker.start_link(arg)
      # {Dynamicgenservers.Worker, arg},
      # Dynamic crawlers supervisor
      {Dynamicgenservers.CrawlerManager.DynamicClawlerSupervisor, name: :dynamic_clawler},
      # Start to serve requests, typically the last entry
      DynamicgenserversWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dynamicgenservers.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DynamicgenserversWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
