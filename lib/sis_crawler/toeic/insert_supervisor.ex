defmodule SisCrawler.Toeic.InsertSupervisor do
  use Supervisor
  alias SisCrawler.Toeic.ProducerState, as: State
  alias SisCrawler.HttpToeic
  alias SisCrawler.Toeic.{Producer, Consumer}

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    body = HttpToeic.read_base_body()
    cookie = HttpToeic.read_cookie()
    state = State.new()

    children = [
      {Producer, state},
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c1),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c2),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c3),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c4),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c5),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c6),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c7),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c8),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c9),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c10),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c11),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c12),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c13),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c14),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c15),
      Supervisor.child_spec({Consumer, {body, cookie}}, id: :c16),
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
