defmodule SisCrawler.Repo do
  use Ecto.Repo,
    otp_app: :sis_crawler,
    adapter: Ecto.Adapters.Postgres
end
