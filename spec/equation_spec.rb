require 'rspec'
require_relative '../lib/linearSolver.rb'

describe Equation do 

	describe "when given an input function" do
		it "should accept the variable on the left" do
			@equation = Equation.new('4x + 3 = 1')
			@equation.equation.should == '4x + 3 = 1'
		end
		it "should accept the variable on the right" do
			@equation = Equation.new('2=4x * 3')
			@equation.equation.should == '2=4x * 3'
		end
		it "should reject equations of incorrect form" do 
			expect {Equation.new('x^4 + 3 = 1')}.to raise_error
		end
	end

	describe "when parsing" do
		context "equation of form 'ax+b=c'" do
			before(:each) do
				@equation = Equation.new('478x+319=11')
				#@equation.parse_equation
			end 
			it "should determine the correct operator (+-*/)" do 
				@equation.operator.should == '+'
			end
			it "should determine 'a'" do
				@equation.coefficient.should == '478'
			end
			it "should determine 'b'" do	
				@equation.constant.should == '319'
			end
			it "should determine 'c'" do
				@equation.result.should == '11'
			end
			it "should organize operator and values" do
				@equation.organize.should == ['+', 478, 319, 11]
			end	
		end
#		context "equation of form 'c=ax+b'" do
#			before(:each) do
#				@equation = Equation.new('241=999x/111')
#			end
#			it "should determine the correct operator (+-*/)" do 
#				@equation.determine_operator.should == '/'
#			end 
#			it "should determine 'a'" do 
#				@equation.determine_variable_coefficient.should == '999'
#			end
#			it "should determine 'b'" do 
#				@equation.determine_constant.should == '111'
#			end
#			it "should determine 'c'" do 
#				@equation.determine_result.should == '241'
#			end
#			it "should organize operator and values" do
#				@equation.organize.should == ['/', 999, 111, 241]
#			end	
#		end
	end
end