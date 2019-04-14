defmodule SisCrawler.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      SisCrawler.Repo,
      SisCrawler.InsertSupervisor
    ]

    opts = [strategy: :one_for_one, name: SisCrawler.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
