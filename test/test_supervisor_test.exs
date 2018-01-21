defmodule TestSupervisorTest do
  use ExUnit.Case, async: true

  test "Can start a worker" do
    TestSupervisor.start_link([])

    assert {:ok, _pid} = TestSupervisor.start_worker({TestWorker, :start_link, ["1"]})
    assert {:ok, _pid} = TestSupervisor.start_worker({TestWorker, :start_link, ["2"]})
    assert {:ok, _pid} = TestSupervisor.start_worker({TestWorker, :start_link, ["3"]})
    children = DynamicSupervisor.count_children(:test_supervisor)
    assert 3 = children.active
    assert 3 = children.workers
  end

  test "Cannot pass non-list args to supervisor" do
    TestSupervisor.start_link([])
    assert {:error, _} = TestSupervisor.start_worker({TestWorker, :start_link, "2"})
  end


end
