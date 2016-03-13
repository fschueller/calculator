require "rails_helper"

RSpec.describe "routes for Calculation" do 

	it "routes /calculations to root" do
		expect(get("/calculations")).to route_to("calculations#index")
	end

	it "routes /calculations to calculations#create" do 
		expect(post("/calculations")).to route_to("calculations#create")
	end

	it "routes new_calculation to calculations#new" do 
		expect(get("/calculations/new")).to route_to("calculations#new")
	end

	it "routes edit_calculation to calculations#edit" do
		expect(get("/calculations/1/edit")).to route_to("calculations#edit", id: "1")
	end

	it "routes calculation to calculations#show" do 
		expect(get("/calculations/1")).to route_to("calculations#show", id: "1")
	end

	it "routes to calculation#update" do
		expect(patch("/calculations/1")).to route_to("calculations#update", id: "1")
	end

	it "routes to calculation#delete" do
		expect(delete("/calculations/1")).to route_to("calculations#destroy", id: "1")
	end
end