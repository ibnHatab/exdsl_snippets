# File    : combinator.ex

defmodule Combinator do
    @moduledoc """
Provides a function combinators.

type Instrument = String
case class TradedQuantity(instrument: Instrument,
                          quantity: Int)
implicit def tuple2ToLineItem(t: (Instrument, Int)) =
  TradedQuantity(t._1, t._2)

case class ActivityReport(account: String,
                          quantities: List[TradedQuantity]) {
    import scala.collection.mutable._

    def groupBy[T <% Ordered[T]](f: TradedQuantity => T) = {
      val m =
        new HashMap[T, Set[TradedQuantity]]
        with MultiMap[T, TradedQuantity]

      for(q <- quantities)
        m addBinding (f(q), q)

      m.keys.toList
          .sort(_ < _)
          .map(m.andThen(_.toList))
    }
  }

"""
    
    @type t :: String
    defrecord TradedQuantity, 
        [
         instrument: nil :: t(), quantity: 0 :: integer
        ]

    def tuple2ToLineItem({instrument,  quantity}), do:  TradedQuantity.new(instrument: instrument,  quantity: quantity)
    
    defrecord ActivityReport, [account: nil ::String, quantities: nil :: [TradedQuantity] ] do
    # import scala.collection.mutable._
        
        # @spec groupBy(((TradedQuantity()) -> any))
        def groupBy(f, self) do
            m = HashDict.new

            m = Enum.reduce(self.quantities, HashDict.new, fn q, m -> HashDict.put m, f.(q), q end)
            # IO.puts ">> #{inspect m}"
            HashDict.keys(m) |> Enum.sort# |> Enum.map(&1)
        end 
    end
end

alias Combinator, as: C

activityReport = C.ActivityReport.new(account: "john doe",
                                          quantities: ([{"IBM", 1200}, {"GOOGLE ", 2000}, {"GOOGLE", 350},
                                                            {"VERIZON", 350}, {"IBM", 2100}, {"GOOGLE", 1200}] 
                                                       |> Enum.map(C.tuple2ToLineItem(&1)))
                                     )

select = fn(e) -> e.instrument end
activityReport.groupBy(select) |> IO.inspect