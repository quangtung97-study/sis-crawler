defmodule SisCrawler.Toeic.Producer do
  use GenStage
  alias SisCrawler.Toeic.ProducerState, as: State

  def start_link(state) do
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:producer, state}
  end

  def handle_demand(demand, state) do
    {events, new_state} = State.take_demand(state, demand)
    {:noreply, events, new_state}
  end
end
