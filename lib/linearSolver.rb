class LinearMath
	attr_accessor :operator, :coefficient, :constant, :result
end

class Equation < LinearMath
	attr_reader :equation
	def initialize(equation)
		raise TypeError, "Equation must be correct format: 'ax (+-*/) b = c'" if !equation_acceptable?(equation)
		@equation = equation
		self.parse_equation
	end

	def parse_equation
		/(?<coefficient>\d+(?=[a-z]))[a-z]\s?(?<operator>[\+\-\*\/])\s?(?<constant>\d+)\s?\=\s?(?<result>\d+)/ =~ equation
		@coefficient = coefficient
		@operator = operator
		@constant = constant
		@result = result
	end

	def organize
		[operator, coefficient.to_f, constant.to_f, result.to_f]
	end

	private
	def equation_acceptable?(equation)
		equation.match(/((\d+[a-z]\s?[\+\-\*\/]\s?\d+|\d+\s?[\+\-\*\/]\d+[a-z])\s?=\s?\d+|\d+\s?=(\d+[a-z]\s?[\+\-\*\/]\s?\d+|\d+\s?[\+\-\*\/]\d+[a-z]))/)[0] == equation
	end
end

class Solver < LinearMath

	def initialize(equation_vals)
		@operator = equation_vals[0]
		@coefficient = equation_vals[1]
		@constant = equation_vals[2]
		@result = equation_vals[3]
	end

	def solve
		eliminate_constant
		eliminate_coefficient
		@result
	end

	def eliminate_constant	
		case operator
		when '+'
			@result -= constant
		when '-'
			@result += constant
		when '*'
			#raise DivisionByZero, "Divided by 0" if constant == 0
			@result /= constant 
		when '/'
			#raise DivisionByZero, "Divided by 0" if constant == 0			
			@result *= constant
		end
	end

	def eliminate_coefficient
		@result /= coefficient
	end

end

equation = 0
while equation != 'q'
puts "Enter an equation of the form ax + b = c, or q to quit:"
equation = gets.chomp
lambda {
equation = Equation.new(equation)
solver = Solver.new(equation.organize) 
puts "The solution is #{solver.solve}." 
}.call unless equation == 'q'
end 
puts "Thanks for doing math!"
