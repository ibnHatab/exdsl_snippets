# File    : order.ex

defmodule DslBook.Order do
    @moduledoc """
Provides a Order abstraction for DSL

newOrder.to.buy(100.shares.of('IBM')) {
    limitPrice 300
    allOrNone true
    valueAs {qty, unitPrice -> qty * unitPrice - 500}
}


"""
    
    defrecord :order, security: nil, quantity: 0, limitPrice: 0, allOrNone: nil, value: 0,  bs: ""

	  def buy(su, closure) do
		    bs = 'Bought'
		    buy_sell(su, closure)
	  end
	  
	  def sell(su, closure) do
		    bs = 'Sold'
		    buy_sell(su, closure)
	  end
	  
	  defp buy_sell(su, closure) do
		    security = su[0]
		    quantity = su[1]
		    closure.()
	  end
	
    @doc """
Integer protocol to emulate english double predicate: 
100.shares.of('IBM')
"""
    defprotocol Shares do
        @moduledoc """
This is the protocol used by the 'Order' module.
"""
        # @only [Integer]
        def shares(delegate)
        def of(instrument)
    end

    defimpl Shares, for: Number do
        def shares(delegate), do: delegate
        def of(instrument), do: instrument
    end

    def bye(shares // 0, of // "") do
        :order.new.(security: of, quantity: shares)
    end


end

# su = bye.(shares: 100, of: "IBM")

# IO.puts ">> #{inspect su}"

