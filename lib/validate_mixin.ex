# File    : validate_mixin.ex




defmodule Exdsl.ValidateMixin do
    @moduledoc """
Provides a mixin example to validate record parameters
"""
    defmodule TradeValidation do

        defmacro __using__(_opts) do
            # module = __CALLER__.module
            quote do
                import Exdsl.ValidateMixin.TradeValidation
 
            end
        end

        defmacro trd_validate(_attribute, [do: _block]) do
            quote do
                def attribute(val, self) do
                    IO.puts ">> #{inspect val}"
                # raise 'Validation failed' unless check.call(val)
                # self.update_"#{attribute}"(val)
                end
            end
        end

    end


    defrecord Trade, [ref_no: nil, account: nil, instrument: nil, principal: nil] do
        use Exdsl.ValidateMixin.TradeValidation
        
        def ref_no(val, self) do
            IO.puts "ref_no >> #{inspect val}"
        end

        trd_validate :principal do
            val > 100
        end
        
    end

end


alias Exdsl.ValidateMixin.Trade


t = Trade.new
t.principal