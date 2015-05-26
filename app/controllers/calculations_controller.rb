class CalculationsController < ApplicationController
  def index
  	@calculations = Calculation.order("created_at" => :desc).page(params[:page]).per(10)
    @new_calculation = Calculation.new

    if request.xhr?
      render "update_table"
    end

  end

  def create
  	@calculation = Calculation.create(equation: params[:calculation][:equation]) # creates calculation object in database
    if @calculation.persisted?
      flash.clear
    else
      flash[:error] = "No not that. No alphabetical characters and avoid spaces, please!"
    end
    @calculations = Calculation.order("created_at" => :desc).page(1).per(10)

    if request.xhr?
      render "update_table"
    else
  	  redirect_to calculations_path
    end
  end

  def destroy 
    @calculation = Calculation.find(params[:id])
    @calculation.destroy!
    @calculations = Calculation.order("created_at" => :desc).page(params[:page]).per(10)
    
    if request.xhr?
      render "update_table"
    else
      redirect_to calculations_path
    end
  end
end
