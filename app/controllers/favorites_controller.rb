class FavoritesController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		favorite = current_user.favorites.build(post: @post)

		authorize favorite
		if favorite.save
		 flash[:notice] = "Post was favorited."
     redirect_to [@post.topic, @post]
		else
			flash[:error] = "There was an error favoriting the post. Please try again."
      render 'posts/show' 
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
    favorite = @post.favorites.find(params[:id])

    authorize favorite
    if favorite.destroy
      flash[:notice] = "This post was unfavorited."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Could not unfavorite post. Try again."
      redirect_to [@post.topic, @post]
    end
  end
end
