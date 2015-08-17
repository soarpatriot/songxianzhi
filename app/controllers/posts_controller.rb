class PostsController < ApplicationController
   
    
   before_action :current_user
   before_action :js_ticket 
   def index 

   end 

   def new 
     authorize 
     @post = Post.new
   end

   def show
     authorize 
     @post = Post.find(params[:id])
     @comment = Comment.new
     @comments = @post.comments.page params[:page]
     @voters = @post.votes_for.up.by_type(User).voters

     @share_data = Hash.new 
     @share_data[:img_url] = @post.photos.first.image.thumb.url
     @share_data[:title] = @post.description
     @share_data[:content] = @post.description
  
     share_url = share_link_url(post_url(@post))
     @share_data[:link] = share_url 

     @nocestr = 1234567890
     @timestamp = DateTime.now.to_i
     @app_id = "wx5940611bb6faccc3"
     @sign = signature(@nocestr,@timestamp,post_url(@post)) 
   end
    


   def commented
    @post = Post.find(params[:id])
    @comment = Comment.new comment_params
    @comment.user = @current_user
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

   def sent 
     @post = Post.find(params[:id])
     @post.sent!
     redirect_to @post
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
     if @current_user.posts << @post and not @current_user.nil?
       redirect_to @post
     else
       render :new
     end

   end

   def post_params
     params.require(:post).permit(:id,:description,:photo_ids=>[])
   end
   def comment_params
     params.require(:comment).permit(:id, :content)
   end


end
