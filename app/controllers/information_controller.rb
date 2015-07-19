class InformationController < ApplicationController

  before_action :set_information, only: [:show,:like, :commented]

  skip_before_filter :verify_authenticity_token, :only => [:like]

  def index
    @category = Category.find(params[:category_id])
    @information = Information.where(publish:true,category: @category).page params[:page]
  end

  def show
    #binding.pry
    @comment = Comment.new # @information.comments.build
    @category = Category.find(params[:category_id]) unless params[:category_id].nil?
    @comments = @information.comments.page params[:page]
    @information.increment_visit_count
  end

  def like

    #current_user.likes @information unless current_user.nil?

    @has_voted = current_user.voted_for? @information
    @has_voted ? @information.unliked_by(current_user) : @information.liked_by(current_user)
    @has_voted ? @has_voted = false : @has_voted = true
    @likes = @information.get_likes.size

  end

  def commented
    @comment = Comment.new comment_params

    @comment.user_id = current_user.id
    ###comment.save
    if @information.comments << @comment
      #@comment = Comment.new
    end
    #@category = @information.category
    #@comments = @information.comments.page params[:page]

    #render "show"
    redirect_to information_path(@information)
  end



  def comment_params
    params.require(:comment).permit(:id, :content)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_information

    @information = Information.find(params[:id])
  end


end
