defmodule SisCrawler.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :mssv, :integer, null: false
      add :ho, :string, null: false
      add :dem, :string
      add :ten, :string, null: false
      add :ngaysinh, :string, null: false
      add :lop, :string, null: false
      add :chuongtrinh, :string, null: false
      add :trangthai, :integer, null: false

      timestamps()
    end

    create unique_index(:students, [:mssv])
  end
end
