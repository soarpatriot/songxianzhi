class Admin::InformationController < Admin::AdminController

  before_action :set_information, only: [:show, :destroy, :edit, :update]

  def index
    @information = Information.page params[:page]
  end

  def edit

  end

  # PATCH/PUT /information/1
  def update
    if @information.update(information_params)
      redirect_to admin_information_index_path, notice: '信息更新成功'
    else
      render :edit
    end
  end

   # DELETE /information/1
  def destroy
    @information.destroy
    redirect_to admin_information_index_path, notice: '信息删除成功'
  end
  # GET /information/1
  def show

  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_information
    @information = Information.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def information_params
    params.require(:information).permit(:id, :title, :description, :publish,:image, :price, :contact, :mobile_number, :qq, :weixin, :category_id)
  end
end
