defmodule SisCrawler.Toeic.Consumer do
  use GenStage
  alias SisCrawler.HttpToeic
  alias SisCrawler.{Repo, Toeic}

  def start_link({body, cookie}) do
    GenStage.start_link(__MODULE__, {body, cookie}) 
  end

  def init(state) do
    producer = {
      SisCrawler.Toeic.Producer, max_demand: 100, min_demand: 50}
    {:consumer, state, subscribe_to: [producer]}
  end

  def handle_events(students, _from, {body, cookie} = state) do
    for student <- students do
      IO.puts "[DEBUG] #{student.mssv}"
      HttpToeic.post(student.mssv, body, cookie)
      |> HttpToeic.handle()
      |> Enum.each(fn params -> 
        time = DateTime.to_string(DateTime.utc_now())
        IO.puts "[#{time}] Sinh vien: #{student.mssv}, Ngaythi: #{params[:ngaythi]}"
        params = Map.put(params, :student_id, student.id)
        cs = Toeic.changeset(%Toeic{}, params)
        Repo.insert(cs)
      end)
    end
    {:noreply, [], state}
  end

end
