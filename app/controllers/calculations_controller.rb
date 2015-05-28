class CalculationsController < ApplicationController
  before_filter :current_page
  before_filter :load_calculations

  def index
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

    if request.xhr?
      render "update_table"
    else
  	  redirect_to calculations_path
    end
  end

  def destroy 
    @calculation = Calculation.find(params[:id])
    @calculation.destroy!
    
    if request.xhr?
      render "update_table"
    else
      redirect_to calculations_path
    end
  end

private
  def current_page
    @current_page = params[:page]
  end

  def load_calculations
    @calculations = Calculation.order("created_at" => :desc).page(params[:page]).per(10)
  end

end
