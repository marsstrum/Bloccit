class CommentsController < ApplicationController
  def create
  	@topic = Topic.find(params[:topic_id])
  	@post = @topic.posts.find(params[:post_id])
    # this represents a list of comments already created that belongs to the active post
  	@comments = @post.comments
    #now need to create a new comment that belongs to the active post and logged in user
    #technique 1 - preferrred
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user

    #technique 1b alternate preferred
  	#@comment = current_user.comments.build(params.require(:comment).permit(:body))
    #@comment.post = @post

    #technique 2
    #@comment = Comment.new(params.require(:comment).permit(:body))
    #@comment.post = @post
    #@comment.user = current_user

    #Technique 3 don't do this, but this shows how an object is built
    #@comment = Comment.new
    #@comment.body = params[:comment][:body]
    #@comment.post = @post
    #@comment.user = current_user
    
    #@new_comment = Comment.new

     if @comment.save
       flash[:notice] = "Comment was saved."
       redirect_to [@topic, @post]
     else
       flash[:error] = "There was an error saving the comment. Please try again."
       render 'posts/show'
     end
  end


end