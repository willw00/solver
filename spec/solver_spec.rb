require 'rspec'
require_relative '../lib/linearSolver.rb'

describe Solver do 
	context "" do
		before (:each) do 
			equation = Equation.new('8r+3=11')
			@solver = Solver.new(equation.organize)
		end
		it "should have an operator" do 
			@solver.operator.should == '+'
		end
		it "should have a variable coefficient" do 
			@solver.coefficient.should == 8
		end
		it "should have a constant" do 
			@solver.constant.should == 3
		end
		it "should have a result" do 
			@solver.result.should == 11
		end
		it "should eliminate the constant term" do
			@solver.eliminate_constant
			@solver.result.should == 8
		end
		it "should divide result by variable coefficient" do 
			@solver.eliminate_constant
			@solver.eliminate_coefficient
			@solver.result.should == 1
		end
		it "should return the answer" do 
			@solver.solve.should == 1
		end
	end
	it "should raise an error if the operator is '/' and constant is 0" do
		equation = Equation.new('81r/0=11')
		@solver = Solver.new(equation.organize)
		expect {@solver.eliminate_constant}.to raise_error
	end
	it "should raise an error if the operator is '*' and constant is 0" do
		equation = Equation.new('81r*0=11')
		@solver = Solver.new(equation.organize)
		expect {@solver.eliminate_constant}.to raise_error
	end
end