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

	describe "POST #create" do

		it "creates valid calculation" do
			payload = { calculation: { equation: "2+2" } }
			post :create, payload
			expect(Calculation.last.equation).to eq "2+2"
		end

		context "creates invalid calculation" do
			it "puts error" do
				payload = { calculation: { equation: "xyz"} }
				post :create, payload
				expect(flash[:error]).to be_present
				expect(flash[:error]).to include("No not that. No alphabetical characters and avoid spaces, please!")
			end
		end

		context "when xhr request" do
			it "renders partial" do
				payload = { calculation: { equation: "2+2" } }
				xhr :post, :create, payload 
				expect(response).to render_template('update_table')
			end
		end

		context "when not xhr request" do
			it "redirects to index page" do
				payload = { calculation: { equation: "2+2" } }
				post :create, payload
				expect(response).to redirect_to '/calculations'
			end
		end
	 end

	 describe "DELETE #destroy" do

	 	let!(:calculation) { Calculation.create!(id: 2000, equation: "2+2") }

	 	it "looks for calculation by id" do
	 		expect(Calculation).to receive(:find).with(calculation.id.to_s).and_return(calculation)
	 		delete :destroy, id: calculation.id
	 	end

	 	it "deletes calculation" do
	 		delete :destroy, id: calculation.id
	 		expect(Calculation.count).to eq 0
	  end

		context "when xhr request" do
			it "renders partial" do 
				xhr :delete, :destroy, id: calculation.id
				expect(response).to render_template('update_table')
			end
		end

		context "when not xhr request" do
			it "redirects to index page" do
				delete :destroy, id: calculation.id
				expect(response).to redirect_to '/calculations'
			end
		end
	 end
end
