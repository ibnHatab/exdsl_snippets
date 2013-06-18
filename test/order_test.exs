Code.require_file "test_helper.exs", __DIR__

defmodule OrderDefTest do
    @moduledoc """
Provides a 

"""
   
    
end


defmodule OrderTest do
  use ExUnit.Case

  import DslBook.Order
  import DslBook.Order.Shares

  test "order builder" do
      o = :order.new()
      IO.puts ">> #{inspect o}"
      assert(true)
  end

  test "Shares protocol" do
      v = shares 100 #of "IBM"
      IO.puts ">> #{inspect v}"
  end


end
