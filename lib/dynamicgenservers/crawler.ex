defmodule Dynamicgenservers.Crawler do
  use GenServer

  def start_link(url) do
    GenServer.start_link(__MODULE__, %{url: url}, name: {:global, url})
  end

  @impl GenServer
  def init(state) do
    {:ok, state}
  end
end
