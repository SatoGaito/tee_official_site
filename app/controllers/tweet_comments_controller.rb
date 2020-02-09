class TweetCommentsController < ApplicationController
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
    redirect_to tweet_path(comment.tweet_id), notice: "コメントの投稿を削除しました。"
  end

  private
  def tweet_comment_params
    params.require(:tweet_comment).permit(:comment, :user_id, :tweet_id)
  end
end