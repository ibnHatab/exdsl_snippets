# File    : nodes.ex

defmodule Ticker do
    @moduledoc """
Provides a some RPC examples.
"""
    @interval 2000              # 2 sec

    @name :ticker

    def start() do
        pid = spawn(__MODULE__, :generator, [[]])
        :yes = :global.register_name(@name, pid)
    end

    def register(client_pid) do
        :global.whereis_name(@name) <- { :register, client_pid }
    end

    def generator(clients) do
        receive do
            { :register, pid } ->
            IO.puts "registering #{inspect pid}"
            generator([pid|clients])
        after
            @interval -> 
            IO.puts "tick"
            Enum.each clients, fn client ->
                                  client <- { :tick }
                               end
            generator(clients)
        end
    end
end

# File    : Client

defmodule Client  do
    @moduledoc """
Provides a RPC client.
"""
    def start() do
        pid = spawn(__MODULE__, :receiver, [])
        Ticker.register(pid)
    end
    
    def receiver() do
        receive do
            { :tick } -> 
            IO.puts "tock in client"
            receiver
        end
    end
end

# Node.connect :"elixir@marvel"
# Node.list

# func = fn -> IO.puts Node.self end

# spawn(func)

# Node.spawn(:"elixir@marvel", func)
