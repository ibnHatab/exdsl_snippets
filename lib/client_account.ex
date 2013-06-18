# File    : client_account.ex

defmodule ClientAccount do
    @moduledoc """
Provides a Account implementation with defining the implicit context using records.
"""
# Account.create do
#     number "CL-BXT-23765"
#     holders "John Doe", "Phil McCay"
#     address "San Francisco"
#     type "client"
#     email "client@example.com"
# end.save.and_then do |a|
#                       Registry.register(a)
#                       Mailer.new
#                      .to(a.email_address)
#                      .cc(a.email_address)
#                      .subject("New Account Creation")
#                      .body("Client account created for #{a.no}")
#                      .send
# end


    defrecord Account, [number: nil, holders: nil, address: nil, type: nil, email: nil] do
        def create(block) do
            Account.new(block)
        end
        def save(self) do
            IO.puts ">> Save #{self.number}"
            self
        end
        def and_then(process, self) do
            IO.puts ">> Process #{self.number}"
            process.(self)
            self
        end
    end
end

defmodule Registry do
    def register(rec) do
        IO.puts ">> Register #{rec.number}"
    end

    defrecord Mailer, [to: nil, cc: nil, subj: nil, body: nil] do
        def send(mail) do
            IO.puts ">> Sending: #{inspect mail}"
        end
    end

end


alias ClientAccount.Account
alias Registry.Mailer

a = Account.create(number:  "CL-BXT-23765",
                   holders: "John Doe",
                   address: "San Francisco",
                   type:    "client",
                   email:   "client@example.com")
.save.and_then (function do 
                    a ->
                    Registry.register(a)
                    Mailer.new()
                    .to(a.email)
                    .cc(a.email)
                    .subj("New Account Creation")
                    .body("Client account created for #{a.number}")
                    .send
                end)

IO.puts ">> Inspect #{inspect a}"



