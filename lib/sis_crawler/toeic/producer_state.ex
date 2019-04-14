defmodule SisCrawler.Toeic.ProducerState do
  alias SisCrawler.{Repo, Student}

  defstruct students: []

  defp get_students() do
    Repo.all(Student)
  end

  def new() do
    %__MODULE__{students: get_students()}
  end

  def take_demand(state, demand) do
    events = Enum.take(state.students, demand)
    students = Enum.drop(state.students, length(events))
    new_state = %{state | students: students}
    {events, new_state}
  end
end
