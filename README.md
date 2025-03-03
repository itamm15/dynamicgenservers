# Dynamicgenservers

```elixir
iex(1)> Dynamicgenservers.CrawlerManager.start_crawler("one")
#PID<0.358.0>
iex(2)> DynamicSupervisor.count_children(Dynamicgenservers.CrawlerManager.DynamicClawlerSupervisor)
%{active: 1, workers: 1, supervisors: 0, specs: 1}
iex(3)> Dynamicgenservers.CrawlerManager.start_crawler("second")
#PID<0.359.0>
iex(4)> DynamicSupervisor.count_children(Dynamicgenservers.CrawlerManager.DynamicClawlerSupervisor)
%{active: 2, workers: 2, supervisors: 0, specs: 2}
iex(5)> pid = GenServer.whereis({:global, "one"})
#PID<0.358.0>
iex(6)> Dynamicgenservers.CrawlerManager.terminate_crawler(pid)
:ok
iex(7)> DynamicSupervisor.count_children(Dynamicgenservers.CrawlerManager.DynamicClawlerSupervisor)
%{active: 1, workers: 1, supervisors: 0, specs: 1}
iex(8)>
```
