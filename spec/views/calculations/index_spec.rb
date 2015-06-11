require 'rails_helper'

RSpec.describe "calculations/index" do

	context "table" do
		it "checks for calculation table" do 
			assign(:calculations, Calculation.page)
			assign(:new_calculation, Calculation.new)
			
			html = Nokogiri::HTML.parse(render)

			expect(html.css("tbody#calculations").any?).to be true
		end

		it "creates rows for each calculation" do
			13.times { |n| Calculation.create(equation: n.to_s)}
			assign(:calculations, Calculation.page)
			assign(:new_calculation, Calculation.new)

			html = Nokogiri::HTML.parse(render)

			expect(html.css("tbody#calculations tr").count).to eq Calculation.count
		end
	end

	 context "pagination" do
	 	it "matches number of pages" do
	 		13.times { |n| Calculation.create(equation: n.to_s)}
	 		assign(:calculations, Calculation.page(7).per(1))
	 		assign(:new_calculation, Calculation.new)

	 		html = Nokogiri::HTML.parse(render)

	 		buttons = html.css("div#paginator ul li a")
	 		expect(buttons.map &:text).to match_array(
	 		  ['« First', '‹ Prev', '…', '3', '4', '5', '6', '7', '8', '9', '10', '11', '…', 'Next ›', 'Last »' ]
	 		)

		end		

		it "expects buttons inside of unordered list" do
			13.times { |n| Calculation.create(equation: n.to_s)}
			assign(:calculations, Calculation.page.per(10))
			assign(:new_calculation, Calculation.new)

			html = Nokogiri::HTML.parse(render)

			expect(html.css("div#paginator ul li a")).to be_any
		end 
	end

	context "form" do 
		it "renders corresponding partial" do
			assign(:calculations, Calculation.page)
			assign(:new_calculation, Calculation.new)

			html = Nokogiri::HTML.parse(render)
			
			expect(html.css("div#equation_form form")).to be_any
		end
		
	end


end