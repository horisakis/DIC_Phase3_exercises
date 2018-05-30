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
    @tweet.image.retrieve_from_cache! params[:cache][:image]

    if @tweet.save
      InfoMailer.info_mail(@tweet).deliver
      redirect_to tweets_path, notice: '投稿しました'
    else
      render 'new'
    end
  end

  def new
    if params[:back]
      @tweet = Tweet.new(tweet_params)
      @tweet.image.retrieve_from_cache! params[:cache][:image]

    else
      @tweet = Tweet.new
    end
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
    params.require(:tweet).permit(:content, :image, :image_cache)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
