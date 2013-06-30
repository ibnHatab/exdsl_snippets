
defmodule DslBook do

    def or_else([], _), do: false
    def or_else([f | fs], X), do: or_else(fs, X, f.(X))
 
    def or_else(fs, X, false), do: or_else(fs, X)
    def or_else(_, _, true), do: true

    # def or_else(Fs, _, {false, Y}), do: or_else(Fs, Y)
                    
end

[function(Kernel.is_integer/1), function(Kernel.is_atom/1), function(Kernel.is_list/1)]
# is = DslBook.or_else([function(Kernel.is_integer/1)], 3.1)
# IO.inspect is