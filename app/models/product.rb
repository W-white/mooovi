class Product < ApplicationRecord
	has_many :reviews
	
	has_one_attached :image 
	
	validates :tag,
			  :title, 
			  presence: true
	
	def review_average
		self.reviews.average(:rate).round	
	end
	
	
end
