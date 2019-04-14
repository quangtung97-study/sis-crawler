defmodule SisCrawler.ProducerState do
  import SisCrawler, only: [mssv_from: 2]
  alias SisCrawler.{Repo, Student}

  defstruct terms: [], index: 0, students: MapSet.new()

  def get_students() do
    Repo.all(Student)
    |> Stream.map(fn student -> student.mssv end)
    |> MapSet.new()
  end

  def empty?(%__MODULE__{terms: []}), do: true

  def empty?(%__MODULE__{}), do: false

  def next(%__MODULE__{terms: []} = state), do: state

  def next(%__MODULE__{terms: [_|tail]} = state) do
    if state.index == 9999 do
      %{state | terms: tail, index: 0}
    else
      %{state | index: state.index + 1}
    end
  end

  def to_mssv(%__MODULE__{terms: [term|_], index: index}) do
    mssv_from(term, index)
  end

  def insertion_cond(%__MODULE__{} = state) do
    mssv = to_mssv(state)
    !MapSet.member?(state.students, mssv)
  end
end
