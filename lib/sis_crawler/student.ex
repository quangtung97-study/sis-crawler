defmodule SisCrawler.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :mssv, :integer
    field :ho, :string
    field :dem, :string
    field :ten, :string
    field :ngaysinh, :string
    field :lop, :string
    field :chuongtrinh, :string
    field :trangthai, :integer

    timestamps()
  end

  def changeset(student, params) do
    student
    |> cast(params, [
      :mssv, :ho, :dem, :ten, 
      :ngaysinh, :lop, :chuongtrinh, :trangthai
    ])
    |> validate_required([
      :mssv, :ho, :ten, 
      :ngaysinh, :lop, :chuongtrinh, :trangthai
    ])
    |> unique_constraint(:mssv)
  end
end
