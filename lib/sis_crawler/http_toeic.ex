defmodule SisCrawler.HttpToeic do

  def read_base_body() do
    File.read!("toeic-post-body")
  end

  def read_cookie() do
    String.replace(File.read!("toeic-cookie"), "\n", "")
  end

  def post(mssv, base_body, cookie) do
    url = "http://sis.hust.edu.vn/ModuleGradeBook/ViewToeicMarks.aspx"
    content_type = {"Content-Type", 
      "application/x-www-form-urlencoded; charset=UTF-8"}
    cookie = {"Cookie", cookie}
    host = {"Host", "sis.hust.edu.vn"}
    origin = {"Origin", "http://sis.hust.edu.vn"}
    referer = {"Referer", "http://sis.hust.edu.vn/ModuleGradeBook/ViewToeicMarks.aspx"}
    user_agent = {"User-Agent", 
      "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36"}
    body = String.replace(base_body, "20151740", Integer.to_string(mssv))

    options = [cookie, content_type, host, origin, referer, user_agent]
    case HTTPoison.post(url, body, options) do
      {:ok, result} -> 
        result.body
      {:error, _} -> ""
    end
  end

  defp parse_or_zero(cols, index) do
    case Integer.parse(Enum.at(cols, index)) do
      {num, _} -> num
      :error -> 0
    end
  end

  def handle(html) do
    html = String.replace(html, "0|/*DX*/({'id':0,'result':'", "")
    (0..9)
    |> Stream.map(fn num -> 
      "tr#MainContent_gvStudents_DXDataRow#{num} td"
    end)
    |> Stream.map(&Floki.find(html, &1))
    |> Stream.take_while(&(is_list(&1) && length(&1) != 0))
    |> Stream.map(&Enum.map(&1, fn {_, _, [entry]} -> entry end))
    |> Stream.map(fn cols ->
      if !is_list(cols) || length(cols) < 9 do
        %{}
      else
        %{
          mssv: parse_or_zero(cols, 0),
          hocky: parse_or_zero(cols, 3),
          ghichu: Enum.at(cols, 4),
          ngaythi: Enum.at(cols, 5),
          diemnghe: parse_or_zero(cols, 6),
          diemdoc: parse_or_zero(cols, 7),
          diemtong: parse_or_zero(cols, 8),
        }
      end
    end)
    |> Enum.to_list()
  end

end
