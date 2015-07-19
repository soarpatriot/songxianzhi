class I::ActivitiesController < I::BaseController

  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /information
  def index
    @activities = current_user.shop.activities.page params[:page]
  end

  # GET /information/1
  def show

  end

  # GET /information/new
  def new
    @activity = Activity.new
  end

  # GET /information/1/edit
  def edit
  end

  # POST /information
  def create
    @activity = Activity.new(activity_params)

    if current_user.shop.activities <<  @activity
      redirect_to [:i, current_user.shop], notice: '信息创建成功'
    else
      render :new
    end
  end

  # PATCH/PUT /information/1
  def update
    if @activity.update(activity_params)
      redirect_to [:i, current_user.shop], notice: '信息更新成功'
    else
      render :edit
    end
  end

  # DELETE /information/1
  def destroy
    @activity.destroy
    redirect_to i_activies_path, notice: '信息删除成功'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    @activity = Activity.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def activity_params
    params.require(:activity).permit(:id, :title, :description, :price, :image)
  end
end
