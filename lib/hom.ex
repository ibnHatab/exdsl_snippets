# File    : hom.ex

defmodule HOM do
    @moduledoc """
Provides a Higher Order Message example.
http://nat.truemesh.com/archives/000535.html
"""

    defrecord Claimant, name: nil ::String.t(), age: nil, gender: nil, benefits: 0 do

        def initialize(block) do
            Claimant.new(block)
        end

        def retire?(self) do
            self.gender == :male && self.age >= 65
            || self.gender == :female && self.age >= 60
        end

        def receive_benefit(amount, self) do
            self.update_benefits(&1 + amount)
        end
    end


end

alias HOM.Claimant

[
  [name: "Peter Gibbons",  age: 42, gender: :male],
  [name: "Michael Bolton", age: 60, gender: :female]
]
|> Enum.map( Claimant.initialize(&1) )
|> Enum.filter_map( Claimant.retire?(&1), Claimant.receive_benefit(100, &1) )
|> IO.inspect

#|> Enum.map(Claimant.retire?(&1))

# Mini Language
# claimants.select {|e| e.retired?}.each {|e| e.receive_benefit 50}
# claimants.where.retired?.do.receive_benefit 50
# claimants where retired do receiveBenefit: 50.
# (claimants.having.age > 100).do.receive_benefit 25
# working_claimants = claimants.unless.retired?
# sorted = claimants.in_reverse_order_of.benefits
# total_benefits = claimants.sum.benefits
# names = claimants.extract.name

# Wrapper
# class BenefitsReport
#     def initialise(claimant)
#         @claimant = claimant
#     end

#     def display
#         puts "#{@claimant.name}\t#{@claimant.benefits}\n"
#     end
# end

# claimants.in_reverse_order_of.benefts.as(BenefitsReport).display
