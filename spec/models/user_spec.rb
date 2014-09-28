require 'rails_helper'

describe User do
	
	include TestFactories

	describe "#favorited(post)" do
		before do
			@post = associated_post
			@user = authenticated_user
		end
		it "returns 'nil' if the user has not favorited the post" do
			#expect a user with no favorite to eq nil
			expect( @user.favorites.find_by_post_id(@post.id) ).to eq(nil)
		end

		it "returns the appropriate favorite if it exists" do
			#expect a user with a favorite to eq favorite
			favorite = @user.favorites.where(post: @post).create
			expect( @user.favorites.find_by_post_id(@post.id).class ).to eq(Favorite)
		end
	end
end