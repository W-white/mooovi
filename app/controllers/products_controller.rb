class ProductsController < RankingController
  before_action :authenticate_user!, only: :search
  require "date"
  
  
  
  def index
    # productsテーブルから最新順に作品を２０件取得する
    @products = Product.order('id ASC').limit(20)
  end

  def show
    # productsテーブルから該当するidの作品情報を取得し@productの変数へ代入する処理を書いて下さい
    @product = Product.find(params[:id]) # 問題3ではこのコードは消して新しくコードを書いてください
  end

  def new
    @product = Product.new
  end
  
  def create
    
    if Product.create(create_params)
      redirect_to :root and return
    else
      redirect_to :new_product_path and return
    end
  end
  
  def edit
    @product = Product.find(params[:id])
    
  end
  
  def update
    @product = Product.find(params[:id])
    d = Date.today
    @product.image_url = d.year + d.yday
    @product.update(update_params)
    
    redirect_to :root and return
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to :root and return
  end

  def search
    unless params[:keyword].blank?
      keyword = "%#{params[:keyword]}%"
      @products = Product.find_by_sql(["select * from products where title like ? LIMIT 20", keyword])
    else
      keyword = "%#{params[:keytag]}%"
      @products = Product.find_by_sql(["select * from products where tag like ? LIMIT 20", keyword])
    end
  end
  
  
  
  
  private
  def create_params
    
    params.require(:product).permit(:title, :image, :tag).merge(user_id: current_user.id)
  end
  
  def update_params
    params.require(:product).permit(:title, :image, :user_id, :image_url, :tag)
  end
  
  
  
  
end
