defmodule SisCrawler.Producer do
  use GenStage
  alias SisCrawler.ProducerState

  def start_link({terms, students}) do
    state = %ProducerState{terms: terms, students: students}
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:producer, state}
  end

  def handle_demand(demand, state) do
    states =
      Stream.iterate(state, &ProducerState.next/1)
      |> Stream.take_while(&!ProducerState.empty?(&1))
      |> Stream.filter(&ProducerState.insertion_cond/1)
      |> Enum.take(demand)

    last = List.last(states)
    if last == nil do
      {:noreply, [], %ProducerState{students: state.students}}
    else
      events =
        states 
        |> Stream.map(&ProducerState.to_mssv(&1))
        |> Enum.to_list()
      {:noreply, events, ProducerState.next(last)}
    end
  end
end
