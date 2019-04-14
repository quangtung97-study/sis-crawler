defmodule SisCrawler do

  def read_base_body() do
    File.read!("post-body")
  end

  def mssv_from(term, index) do
    term * 10000 + index
  end

  def post_student_info(mssv, base_body) do
    url = "http://sis.hust.edu.vn/ModuleSearch/GroupList.aspx"
    content_type = {"Content-Type", 
      "application/x-www-form-urlencoded; charset=UTF-8"}
    body = String.replace(base_body, "20154281", Integer.to_string(mssv))
    case HTTPoison.post(url, body, [content_type]) do
      {:ok, result} -> 
        result.body
      {:error, _} -> ""
    end
  end

  def handle_student_info(body) do
    html = String.replace(body, "0|/*DX*/({'id':0,'result':'", "")
    cols = 
      Floki.find(html, "tr#MainContent_gvStudents_DXDataRow0 td")
      |> Enum.map(fn {_, _, [entry]} -> entry end)

    if length(cols) < 8 do
      %{}
    else
      %{
        mssv: String.to_integer(Enum.at(cols, 0)),
        ho: Enum.at(cols, 1),
        dem: Enum.at(cols, 2),
        ten: Enum.at(cols, 3),
        ngaysinh: Enum.at(cols, 4),
        lop: Enum.at(cols, 5),
        chuongtrinh: Enum.at(cols, 6),
        trangthai: Enum.at(cols, 7),
      }
    end
  end

end
