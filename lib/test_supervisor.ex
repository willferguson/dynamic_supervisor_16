defmodule TestSupervisor do
    use DynamicSupervisor

    def start_link([]) do
      DynamicSupervisor.start_link(__MODULE__, [], name: :test_supervisor)
    end

    def init(_arg) do
      DynamicSupervisor.init(strategy: :one_for_one)
    end

    def start_worker({module, function, args}) when is_list(args) do
      child_spec = Supervisor.child_spec(
                              module,
                              start: {module, function, args},
                              restart: :temporary)

      DynamicSupervisor.start_child(:test_supervisor, child_spec)
    end

    def start_worker(_args) do
      {:error, "Args must be a list"}
    end
end
