class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[edit update destroy]

  def root; end

  def confirm
    @tweet = Tweet.new(tweet_params)
    render 'new' if @tweet.invalid?
  end

  def index
    @tweets = Tweet.all
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to list_tweets_path, notice: '投稿しました'
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
      redirect_to list_tweets_path, notice: '編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @tweet.destroy
    redirect_to list_tweets_path, notice: '削除しました'
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
