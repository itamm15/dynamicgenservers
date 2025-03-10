defmodule Dynamicgenservers.Crawler do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: {:global, state[:url]})
  end

  @impl GenServer
  def init(state) do

    state
    |> schedule_work(:stop_crawling, 5000)
    |> schedule_work(:crawl)
    |> then(&({:ok, &1}))
  end

  @impl GenServer
  def handle_info(:crawl, state) do
    Process.sleep(6000)
    if state[:flush_message?] do
      IO.inspect(self(), label: "process")
      IO.puts("Before flushing messages..")
      # IO.inspect(Process.info(self()), label: "Process.info()")
      flush_messages(:stop_crawling)
      IO.puts("Messages flushed!")
      # IO.inspect(Process.info(self()), label: "Process.info()")
    end

    {:noreply, state}
  end

  def handle_info(:stop_crawling, state) do
    IO.puts("Hello from stop_crawling!")

    {:noreply, state}
  end

  defp schedule_work(state, msg, time \\ 0) do
    ref = Process.send_after(self(), msg, time)

    Map.put(state, Atom.to_string(msg) <> "_time_ref", ref)
  end

  def flush_messages(message) do
    receive do
      ^message -> flush_messages(message)
    after
      0 -> :ok
    end
  end
end
