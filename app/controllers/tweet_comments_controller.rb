class TweetCommentsController < ApplicationController

  before_action :ensure_correct_user, only: :destroy
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    if user_signed_in?
      comment = current_user.tweet_comments.new(tweet_comment_params)
      comment.tweet_id = tweet.id
      if comment.save
        redirect_to tweet_path(tweet), notice: "コメントの投稿が完了しました。"
      else 
        redirect_to tweet_path(tweet), notice: "コメントを入力してください。"
      end
    end
  end

  def destroy
    comment = TweetComment.find_by(id: params[:id], tweet_id: params[:tweet_id])
    comment.delete
    redirect_to tweet_path(comment.tweet_id), notice: "コメントを削除しました。"
  end

  private
  def tweet_comment_params
    params.require(:tweet_comment).permit(:comment, :user_id, :tweet_id)
  end

  def ensure_correct_user
    @tweet_comment = TweetComment.find(params[:id])
    if user_signed_in? && @tweet_comment.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to tweets_path(@tweet_comment.tweet)
    end
  end
end