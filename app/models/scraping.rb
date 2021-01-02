class Scraping
	def self.movie_urls
		links = []
		agent = Mechanize.new
		
		next_url = ""

    while true do

      current_page = agent.get("http://review-movie.herokuapp.com" + next_url)
      elements = current_page.search(".entry-title a")
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      # 「次へ」を表すタグを取得
      next_link = current_page.at('.next a')

      # next_linkがなかったらwhile文を抜ける
      unless current_page.at('.next a')
        break
      end

      # そのタグからhref属性の値を取得
      next_url = next_link[:href]


    end
		
		links.each do |link|
			get_product('http://review-movie.herokuapp.com/' + link)	
		end
	end
	
	def self.get_product(link)
		agent = Mechanize.new
		current_page = agent.get(link)
		image = current_page.at('.entry-content .post-image')[:src] if current_page.at('.post-image')
		text = current_page.search('.entry-title').inner_text
		
		product = Product.where(title: text, image_url: image).first_or_initialize
		detail = current_page.at('.entry-content p').inner_text if current_page.at('.entry-content p')
		product.director = current_page.at('.director span').inner_text if current_page.at('.director span')
		product.open_date = current_page.at('.date span').inner_text if current_page.at('.date span')
		
		product.detail = detail
		product.save
		
		
	end
end