defmodule Dynamicgenservers.CrawlerManager do
  alias Dynamicgenservers.Crawler

  defmodule DynamicClawlerSupervisor do
    use DynamicSupervisor

    def start_link(opts) do
      DynamicSupervisor.start_link(__MODULE__, opts, name: __MODULE__)
    end

    @impl DynamicSupervisor
    def init(_opts) do
      DynamicSupervisor.init(strategy: :one_for_one)
    end
  end

  def start_crawler(url) do
    case DynamicSupervisor.start_child(DynamicClawlerSupervisor, {Crawler, url: url}) do
      {:ok, pid} ->
        pid

      {:error, {:already_started, pid}} ->
        pid
    end
  end

  def terminate_crawler(pid) do
    DynamicSupervisor.terminate_child(DynamicClawlerSupervisor, pid)
  end
end
