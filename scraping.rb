require 'mechanize'

agent = Mechanize.new
page = agent.get("https://third-scraping.herokuapp.com/")
elements = page.search('.etc div')

elements.each do |ele|
	puts ele.inner_text	
end