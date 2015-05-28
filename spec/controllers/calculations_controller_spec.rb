require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
	describe "GET #index" do

		it "loads last calculations" do
			13.times { |n| Calculation.create(equation: n.to_s)}	

			get :index

			expect(assigns :calculations).to eq Calculation.order(created_at: :desc).first(10)
		end

		it "initializes new calculation" do
			get :index

		 	expect(assigns :new_calculation).to be_a_new(Calculation)
		end

		it "paginates calculations" do
			13.times { |n| Calculation.create(equation: n.to_s)}

			get :index, page: 2 

			expect(assigns :calculations).to eq Calculation.order(created_at: :desc).last(3)
		end

		context "when xhr request" do
			it "renders partial" do
				xhr :get, :index
				expect(response).to render_template('update_table')
			end
		end

		context "when not xhr request" do
			it "renders whole template" do 
				get :index
				expect(response).to render_template(:index)
			end
		end

	end

	# describe "POST #create"
	# 	it "creates valid calculation" do
	# 	end

	# 	context "creates invalid calculation" do
	# 		it "puts error" do
	# 		end
	# 	end

	# 	context "when xhr request" do
	# 		it "renders partial" do
	# 		end
	# 	end

	# 	context "when not xhr request" do
	# 		it "redirects to index page" do
	# 		end
	# 	end
	# end

end
