defmodule SisCrawler.Toeic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "toeics" do
    belongs_to :student, SisCrawler.Student
    field :ghichu, :string
    field :hocky, :integer
    field :ngaythi, :string
    field :diemnghe, :integer
    field :diemdoc, :integer
    field :diemtong, :integer

    timestamps()
  end

  def changeset(toeic, params) do
    toeic
    |> cast(params, [:student_id, :ghichu, :hocky, 
      :ngaythi, :diemnghe, :diemdoc, :diemtong])
    |> validate_required([:student_id, :hocky, 
      :ngaythi, :diemnghe, :diemdoc, :diemtong])
    |> unique_constraint(:mssv_ngaythi, 
      name: :unique_index_mssv_ngaythi)
  end
end
