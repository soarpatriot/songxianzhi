class PostsController < ApplicationController
   
    
   before_action :current_user, except:[:new]
    
   def index 

   end 

   def new 
     authorize 
     @post = Post.new
   end

   def show
     @post = Post.find(params[:id])
     @comment = Comment.new
     @comments = @post.comments.page params[:page]
   end


   def commented
    @post = Post.find(params[:id])
    @comment = Comment.new comment_params

    ###comment.save
    @post.comments << @comment
      #@comment = Comment.new
    #@category = @information.category
    #@comments = @information.comments.page params[:page]

    #render "show"
    redirect_to @post
  end


   def upload
     @post = Post.new
     render "new"
   end

   def edit

   end

   def update
   end
   def like
      @post = Post.find(params[:id])
      @has_voted = @current_user.voted_for? @post
      @has_voted ? @post.unliked_by(@current_user) : @post.liked_by(@current_user)
      @has_voted ? @has_voted = false : @has_voted = true
      @voters = @post.votes_for.up.by_type(User).voters
      @likes = @post.get_likes.size

   end

   def create
     
     @post = Post.new(post_params)
     unless post_params[:photo_ids].blank?
       photos = Photo.find(post_params[:photo_ids])
       @post.photos = photos
     end
     @post.save
     @current_user.posts << @post  unless @current_user.nil?
     redirect_to @post
   end

   def post_params
     params.require(:post).permit(:id,:description,:photo_ids=>[])
   end
   def comment_params
     params.require(:comment).permit(:id, :content)
   end


end
