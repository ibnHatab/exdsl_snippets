# File    : dispatch.ex

defmodule Dispatch do
    @moduledoc """
Provides a protocol
"""
    defprotocol Blank do
        @moduledoc """
This is the protocol used by the '-Blank' module.
"""
        @only [Number, List, Atom]
        def blank?(data)        
    end
    
    defimpl Blank, for: Number do
        def blank?(_number), do: false
    end

    defimpl Blank, for: List do
        def blank?([]), do: true
        def blank?(_), do: false
    end

    IO.puts Blank.blank?([])        
    
end     
