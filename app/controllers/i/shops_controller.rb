class I::ShopsController < I::BaseController

  before_action :load_shop, except: [:index, :new, :guide, :create]

  def new
      @shop = Shop.new
  end

  def show
      @information = @shop.information.page params[:page]
  end

  def guide

  end

  def display

  end

  def edit

  end

  def update
    if @shop.update(shop_params)
          redirect_to [:i,@shop], notice: '商店更新成功'
    else
          render :edit
    end
  end

  def create

    @shop = Shop.new(shop_params)

    if @shop.save
      @shop.update user:current_user
      redirect_to [:i,@shop], notice: '商店创建成功'
    else
      render "new"
    end

  end

  def destroy
    @shop.destroy
    redirect_to information_index_url, notice: '商店删除成功'
  end

  def  load_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:id, :title, :description, :image, :contact, :address, :phone, :url)
  end



end
