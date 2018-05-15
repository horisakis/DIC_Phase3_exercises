class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[edit update destroy]
  before_action :redirect_to_log_in, only: %i[new edit show destroy]

  def root; end

  def confirm
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    render 'new' if @tweet.invalid?
  end

  def index
    @tweets = Tweet.all
    @favorites = logged_in? ? current_user.favorites : nil
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id

    if @tweet.save
      redirect_to tweets_path, notice: '投稿しました'
    else
      render 'new'
    end
  end

  def new
    @tweet = params[:back] ? Tweet.new(tweet_params) : Tweet.new
  end

  def edit; end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: '編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: '削除しました'
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
