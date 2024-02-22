defmodule BecomicsWeb.MetricsTest do
  use ExUnit.Case

  setup_all do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Becomics.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(Becomics.Repo, {:shared, self()})
    Application.ensure_all_started(:gun)
    :ok
  end

  test "Prometheus" do
    values_for_prometheus()
    {host, _port} = host_port()
    ## Default port for TelemetryMetricsPrometheus.
    {:ok, pid} = :gun.open(host, 9568)
    {:ok, _} = :gun.await_up(pid)

    stream = :gun.get(pid, "/metrics")
    {:response, :nofin, status, _headers} = :gun.await(pid, stream)
    assert status === 200
    {:ok, body} = :gun.await_body(pid, stream)

    :gun.shutdown(pid)
    assert Enum.count(String.split(body, "phoenix_endpoint", parts: 2)) === 2
    assert Enum.count(String.split(body, "becomics_repo_query", parts: 2)) === 2
  end

  defp host_port() do
    endpoint = Application.get_env(:becomics, BecomicsWeb.Endpoint)
    http = endpoint[:http]
    {http[:ip], http[:port]}
  end

  defp values_for_prometheus() do
    Becomics.list_publishes()

    {host, port} = host_port()
    {:ok, pid} = :gun.open(host, port)
    {:ok, _} = :gun.await_up(pid)
    stream = :gun.get(pid, "/")
    {:response, :nofin, 200, _headers} = :gun.await(pid, stream)
    :gun.shutdown(pid)
  end
end
