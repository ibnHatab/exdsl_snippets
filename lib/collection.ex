
defmodule MyCollection do

    def map([], _func), do: []
    def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]
    
    def child(elem, func, parent) do
        parent <- {self, func.(elem)}
    end

    def spawn_children(collection, func) do
        map collection, fn el -> spawn(__MODULE__, :child, [el, func, self]) end
    end

    def collect_result(pids) do
        map pids, fn pid -> receive do: ( {^pid, value} -> value) end
    end

    def pmap(collection, func) do
        collection |> spawn_children(func) |> collect_result
    end


end

IO.inspect MyCollection.map [1,2,3,4], fn x -> x*x end
IO.inspect MyCollection.pmap [1,2,3,4], fn x -> x*x end 

IO.inspect {
            try do
                raise "some error"
            rescue
                 x in [RuntimeError] -> 
                IO.inspect x
                "rescued: " <> x.message
            end
           }

