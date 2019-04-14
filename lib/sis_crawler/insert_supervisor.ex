defmodule SisCrawler.InsertSupervisor do
  use Supervisor
  alias SisCrawler.ProducerState

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    body = File.read!("post-body")

    terms = [2016, 2017, 2009]

    children = [
      {SisCrawler.Producer, {terms, ProducerState.get_students()}}, 
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c1),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c2),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c3),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c4),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c5),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c6),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c7),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c8),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c9),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c10),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c11),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c12),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c13),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c14),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c15),
      Supervisor.child_spec({SisCrawler.Consumer, body}, id: :c16),
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
