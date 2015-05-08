class CalculatorController < ApplicationController
  def new
  	#@calculations = Calculation.last(10)
  	# if params["first_id"]
  	# 	@calculations = Calculation.where("id >= #{params['first_id']}").limit(10)
  	@calculations = Calculation.order("created_at" => :desc).page(params[:page]).per(10)
  end

  def create
  	@calculation = Calculation.create(equation: params[:q]) # creates calculation object in database
	flash[:error] ="No not that. No alphabetical characters and avoid spaces, please!" unless @calculation.persisted?
  	redirect_to new_calculator_path	
  end

  def enter
  end
end
