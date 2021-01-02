class RankingController < ApplicationController
  layout 'review_site'
  before_action :ranking
  def ranking
    ids = Product.order('updated_at DESC').limit(3)
# 	ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
    # @ranking = ids.map { |i| Product.find(i) }
    @ranking = ids
    
  end
end
