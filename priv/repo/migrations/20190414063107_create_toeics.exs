defmodule SisCrawler.Repo.Migrations.CreateToeics do
  use Ecto.Migration

  def change do
    create table(:toeics) do
      add :student_id, references(:students)
      add :hocky, :integer, null: false
      add :ghichu, :string
      add :ngaythi, :string, null: false
      add :diemnghe, :integer, null: false
      add :diemdoc, :integer, null: false
      add :diemtong, :integer, null: false

      timestamps()
    end

    create unique_index(:toeics, [:student_id, :ngaythi], 
      name: :unique_index_mssv_ngaythi)
  end
end
