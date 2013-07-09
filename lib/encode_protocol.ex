
defprotocol Proto do

    def encode(data)
    
end

defmodule Channel do
    # @on_definition  { IO, puts } 

    @type t :: Proto.t
    
    @spec send(t) :: any
    def send(data) do
        IO.inspect @vsn
        Proto.encode(data)
    end
    
    defimpl Proto, for: List do
        def encode(data) do
            Enum.reverse(data)            
        end
    end

    def first_is_zero?(tuple_or_list)
    when elem(tuple_or_list, 1) == 0
    when hd(tuple_or_list) == 0 do
        true
    end

end

IO.puts Channel.send 'hello'

m = case { 1, 2, 3 } do
  { 4, 5, 6 } ->
    "This won't match"
  { 1, x, 3 } when x < 0 ->
    "This will match and assign x to 2"
  _ ->
    "This will match any value"
end

IO.puts m
IO.puts Channel.first_is_zero? [0]

current_pid = self 
spawn fn ->
  current_pid <- { :hello, self }
end

receive do
  { :hello, pid } ->
     IO.puts "Hello from #{inspect(pid)}"
end


receive do
    :waiting ->
    IO.puts "This may never come"
after
    1000 -> # 1 second
    IO.puts "Too late"
end



try do
    throw 13
catch
    number when is_number(number) -> 
    IO.puts number
after
    IO.puts "Didn't catch"
end

{ x, y } = try do
               x = self
               y = self
               { x, y }
           catch
               _ -> { nil, nil }
           end

q = quote do
    defprotocol MyInspect do
        def inspect(thing, opts)
    end
end

# IO.puts Macro.to_binary(Macro.expand q, __ENV__)

[[1],[2],[3]] |> :lists.nth(2, &1).() |> :lists.nth(1, &1).()

if true do
    "This works!"
end

unless true do
    "This will never be seen"
end

IO.puts (cond do
             2 + 2 == 5 ->
             "This will never match"
             2 * 2 == 3 ->
             "Nor this"
             1 + 1 == 2 ->
             "But this will"
             true ->
             "This will always match (equivalent to else)"
         end)

IO.puts __DIR__

import List, only: [duplicate: 2]
duplicate [1], 3 

