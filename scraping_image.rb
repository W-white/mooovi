require 'mechanize'


agent = Mechanize.new
current_page = agent.get("http://review-movie.herokuapp.com/")
# 個別ページのリンクを取得
elements = current_page.search('.entry-title a')

elements.each do |ele|
  # 個別ページから作品画像のURLを取得
  url = ele[:href]
  pag = agent.get("http://review-movie.herokuapp.com/#{url}")
  element = pag.search('.entry-content img')
	  element.each do |el|
	  	puts el[:src]
	  end
end