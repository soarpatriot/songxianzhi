class Admin::ShopsController< Admin::AdminController
    before_action :load_shop, except: [:index, :new]

  def index
      @shops = Shop.page params[:page]
  end
  def new
      @shop = Shop.new
  end

  def show
      @information = @shop.information.page params[:page]
  end


  def destroy
    @shop.destroy
    redirect_to admin_shops_path, notice: '信息删除成功'
  end

  def  load_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:id, :title, :description, :image, :contact, :address, :phone, :url)
  end

end
