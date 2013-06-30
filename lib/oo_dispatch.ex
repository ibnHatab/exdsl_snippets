
# This snippet if from http://www.theerlangelist.com/ "IMMUTABLE
# PROGRAMMING, OO STYLE". It demonstrate "Law of Demeter" which states
# that we should communicate only with our immediate neighbors.

defrecord Employee, id: nil, name: nil, salary: nil

defrecord Company, [
                    name: nil, employees: HashDict.new, autoid: 1
    ] do

    def add_employee(employee, this) do
        this.
        store_employee(employee.id(this.autoid)).
        update_autoid(&1 + 1)
    end
    
    def store_employee(employee, this) do
        this.
        update_employees(HashDict.put(&1, employee.id, employee))
    end

    def get_employee(id, this), do: Dict.get(this.employees, id)

    def update_employee(id, update_fun, this) do
        this.get_employee(id)
        |> this.maybe_update_employee(update_fun)
    end
  
    def maybe_update_employee(nil, _, this), do: this
    def maybe_update_employee(employee, update_fun, this) do
        update_fun.(employee) 
        |> this.store_employee
    end

    def select(pred, this) do        
        lc {k, e} inlist (HashDict.to_list this.employees), pred.(e), do: k
    end
    
end

c = Company.new(name: "Initech").
add_employee(Employee.new(name: "Peter Gibbons",  salary: 10000)).
add_employee(Employee.new(name: "Michael Bolton", salary: 12000))

IO.inspect c
IO.inspect c.get_employee(1)
IO.inspect c.get_employee(5)

c1 = c.update_employee(1, fn(employee) ->
  employee.update_salary(&1 * 1.2)
end)

IO.inspect c1

input = [
  [name: "Peter Gibbons",  salary: 10000],
  [name: "Michael Bolton", salary: 12000]
]

c = Enum.reduce(
  input,                          # enumerable
  Company.new(name: "Initech"),   # initial accumulator
  fn(employee_data, company) ->   # accumulator modifier
    company.add_employee(Employee.new(employee_data))
  end
)

# IO.inspect HashDict.to_list c.employees

# Higher order messages in a nutshell. 
IO.puts ">========================================"

c.select( fn e -> e.salary > 10000 end ) 
|> Enum.map(c.get_employee(&1)) 
|> IO.inspect

