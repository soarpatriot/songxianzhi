class Admin::CategoriesController < Admin::AdminController

   before_action :load_category, only: [ :show,  :edit, :update, :destroy]

  def index
      @categories = Category.page params[:page]
  end
  def new
      @category = Category.new
  end

  def show

  end

  def create
    @category = Category.new category_params
    if  @category.save
       redirect_to admin_categories_path, notice: '类别创建成功'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
          redirect_to admin_categories_path, notice: '类别更新成功'
    else
          render :edit
    end
  end



  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: '类别删除成功'
  end

  def  load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:id, :name,:rank, :description)
  end
end
