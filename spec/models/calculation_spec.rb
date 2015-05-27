require 'rails_helper'

RSpec.describe Calculation, type: :model do
	describe "equation" do
	  it "should have presence validated" do
	  	calculation = Calculation.new

	  	calculation.equation = nil
	  	expect(calculation).not_to be_valid

	  	calculation.equation = '1'
	  	expect(calculation).to be_valid
	  end

	  it "should have format validated" do
	  	calculation = Calculation.new

	  	calculation.equation = "bjkiuzkjugfnfchjz65ktiukhjggdrz54"
	  	expect(calculation).not_to be_valid

	  	calculation.equation = "(2+2.8)*3/4-5"
	  	expect(calculation).to be_valid
	  end


	  it "should be saved to database" do
	  	Calculation.create(equation: "2+2")
	  	expect(Calculation.last.equation).to eq "2+2"
	  end
	end

	describe "evaluation" do
  	it "should happen automatically" do
  		Calculation.create(equation: "2+2")

  		expect(Calculation.last.result).to be_present
  	end

  	it "should be correct" do 
  		Calculation.create(equation: "2+2")
  		expect(Calculation.last.result).to eq 4
  	end
  end
end
