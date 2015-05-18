class CalculationsController < ApplicationController
  def index
  	@calculations = Calculation.order("created_at" => :desc).page(params[:page]).per(10)
  end

  def create
  	@calculation = Calculation.create(equation: params[:q]) # creates calculation object in database
	flash[:error] ="No not that. No alphabetical characters and avoid spaces, please!" unless @calculation.persisted?
  	redirect_to calculations_path	unless request.xhr?
  end

  def destroy 
    @calculation = Calculation.find(params[:id])
    flash[:error] = "Record not found in database. Try again." unless @calculation.exists?
    @calculation.delete
    redirect_to index_calculator_path
  end
end
