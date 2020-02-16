class TweetsController < ApplicationController

  before_action :non_active_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to tweets_path, notice: "ツイートの投稿が完了しました。"
    else
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_comment = TweetComment.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet), notice: "ツイートの更新を完了しました。"
    else
      render :edit
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.delete
    redirect_to tweets_path, notice: "ツイートの投稿を削除しました。"
  end

  private
  def tweet_params
    params.require(:tweet).permit(:tweet)
  end

  def ensure_correct_user
    @tweet = Tweet.find(params[:id])
    if user_signed_in? && @tweet.user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to tweets_path
    end
  end

  def non_active_user
    unless user_signed_in? && current_user.active?
      flash[:notice] = "アカウントがアクティブではありません"
      redirect_to '/'
    end
  end
end