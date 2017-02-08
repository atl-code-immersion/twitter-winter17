class EpicenterController < ApplicationController
  def feed
    @follower_count = 0

    User.all.each do |user|
      if user.following.include?(current_user.id)
        @follower_count += 1
      end
    end

  	@following_tweets = []

  	Tweet.order(created_at: :desc).each do |tweet|
  		if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
  			@following_tweets.push(tweet)
  		end
  	end
  end

  def show_user
  	@user = User.find(params[:id])

    @follower_count = 0

    User.all.each do |user|
      if user.following.include?(@user.id)
        @follower_count += 1
      end
    end
  end

  def now_following
  	current_user.following.push(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end

  def unfollow
  	current_user.following.delete(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  def following
    @user = User.find(params[:id])

    @followed_users = []

    User.all.each do |user|
      if @user.following.include?(user.id)
        @followed_users.push(user)
      end
    end
  end

  def followers
    @user = User.find(params[:id])

    @followers = []

    User.all.each do |user|
      if user.following.include?(@user.id)
        @followers.push(user)
      end
    end
  end
end





