# File    : param_module.ex

defmodule ParamModule do
    @moduledoc """
Provides a 
"""
    
    defrecord :param_module, [id: nil, value: nil] do
        def save(self) do
            :do_stuff
            self.value(42)
        end

        def info(_self) do
            :info
        end
    end

end

v = :param_module.new [id: 1, value: 2]
v.info

c = v.save


IO.puts ">> #{inspect c}"
