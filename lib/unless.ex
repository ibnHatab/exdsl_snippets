
defmodule MacroWorld do

    defmacro unless(condition, opts) do
        quote do            
            # if !unquote(condition), unquote(opts)
            if(!unquote(condition), unquote(opts))
        end
    end

    
end 

c = false

unless(c) do
    IO.puts "unless c"
end

q = quote do
    defprotocol MyInspect do
        def inspect(thing, opts)
    end
end

IO.puts Macro.to_binary(Macro.expand q, __ENV__)

