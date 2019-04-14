defmodule SisCrawler.Consumer do
  use GenStage
  import SisCrawler
  alias SisCrawler.{Repo, Student}

  def start_link(body) do
    GenStage.start_link(__MODULE__, body) 
  end

  def init(body) do
    producer = {
      SisCrawler.Producer, max_demand: 100, min_demand: 50}
    {:consumer, body, subscribe_to: [producer]}
  end

  def handle_events(mssv_list, _from, body) do
    mssv_list
    |> Stream.map(&post_student_info(&1, body))
    |> Stream.map(&handle_student_info(&1))
    |> Enum.each(fn map -> 
      time = DateTime.to_string(DateTime.utc_now())
      IO.puts "[#{time}] Student: #{map[:mssv]}"
      cs = Student.changeset(%Student{}, map)
      Repo.insert(cs)
    end)
    {:noreply, [], body}
  end
end
