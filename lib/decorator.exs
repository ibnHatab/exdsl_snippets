# File    : decorator.exs

defmodule Decorator do
    @moduledoc """
Provides a Dynamic Decorator pattern.
POSSIBLE: Yes but ugly and one step only.
"""
end

defrecord Trade, [ref_no: nil, account: nil, instrument: nil, principal: nil] do

    def initialize(block) do
        Trade.new block
    end

    @dos "Make function overridable"
    defmacro __using__(_opts) do
        quote do
            def value(self) do
                self.principal
            end

            defoverridable [value: 1]
        end
    end

    def with(cl, self) do
        cl.derive(self)        
    end

end


defrecord TaxFree, [parent: nil] do
    use Trade
    
    @doc "greate chain of derivation"
    def derive(up) do
        TaxFree.new(parent: up)
    end

    @doc "Overrid function"
    def value(self) do
        super(self.parent) + self.parent.principal * 0.2
    end
end


tf = Trade.new(ref_no: "r-123", account: "a-123", instrument: "i-123", principal: 200).with(TaxFree)

IO.puts ">> TF #{inspect tf}"
IO.puts ">>---------------------------------------------"
IO.inspect tf.value

