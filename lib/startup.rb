require "employee"

class Startup
  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    if @salaries.has_key?(title)
        return true
    end
    false
  end

  def >(startup)
    if @funding > startup.funding
        return true
    end
    false
  end

  def hire(employee_name, title)
    if !valid_title?(title)
        raise Exception
    else
        @employees << Employee.new(employee_name, title)
    end
  end

  def size
    @employees.size
  end

  def pay_employee(emp)
    emp_salary = @salaries[emp.title]
    if @funding > emp_salary
        emp.pay(emp_salary)
        @funding -= emp_salary
    else
        raise Exception
    end
  end

  def payday
    @employees.each { |emp| pay_employee(emp) }
  end

  def average_salary
    average = 0
    @employees.each do |emp|
        average += @salaries[emp.title]
    end
    average / @salaries.size
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(startup)
    @funding += startup.funding
    startup.salaries.each do |key, val|
        if !@salaries.has_key?(key)
            @salaries[key] = val
        end
    end
    startup.employees.each { |emp| @employees << emp }
    startup.close
  end

end
