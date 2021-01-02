class ReviewsController < RankingController
  before_action :authenticate_user!, only: :new
  
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    # Review.create(create_params)
    @review = Review.create(create_params)
    
    # トップページにリダイレクトする
    redirect_to controller: :products, action: :index
  end
  
  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    
    @review.update(update_params)
    redirect_to :root and return
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to :root and return
  end

  private
  def create_params
    params.require(:review).permit(:genre, :review).merge(product_id: params[:product_id], user_id: current_user.id)
  end
  
  def update_params
    params.require(:review).permit(:genre, :review)
  end
  
  
end
