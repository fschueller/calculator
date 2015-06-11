require 'rails_helper'

RSpec.describe "calculations/update_table" do
	it "renders calculations in table" do 
		Calculation.create(equation: "2+2")
		assign(:calculations, Calculation.page)
		assign(:new_calculation, Calculation.new)

		table_source = /^\$\('#calculations'\).html\('(.+)'\);$/.match(render)[1]

		table_html = Nokogiri::HTML.parse(table_source)
		expect(table_html.css("tr").count).to eq Calculation.count
	end

	it "creates correct link in pagination" do
		13.times { |n| Calculation.create(equation: n.to_s)}
		assign(:calculations, Calculation.page.per(10))
		assign(:new_calculation, Calculation.new)

		paginator_source = /^\$\('#paginator'\).html\('(.+)'\);$/.match(render)[1]
		
		paginator_html = Nokogiri::HTML.parse(paginator_source)
		expect(paginator_html.css("a")[1]["href"]).to match("/?page=2")
	end

	it "adds flash error in javascript" do
		assign(:calculations, Calculation.page)
		assign(:new_calculation, Calculation.new)
		flash[:error] = "yxz"

		error_text = /^\$\('#error'\).html\('(.+)'\);$/.match(render)[1]

		expect(error_text).to eq 'yxz'
	end

end