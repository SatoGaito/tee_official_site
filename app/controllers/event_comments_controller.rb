class EventCommentsController < ApplicationController
  
  before_action :non_active_user, only: [:create, :destroy]
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    if user_signed_in?
      comment = current_user.event_comments.new(event_comment_params)
      comment.event_id = event.id
      if comment.save
        redirect_to event_path(event), notice: "コメントの投稿が完了しました。"
      else 
        redirect_to event_path(event), notice: "コメントを入力してください。"
      end
    end
  end

  def destroy
    comment = EventComment.find_by(id: params[:id], event_id: params[:event_id])
    comment.delete
    redirect_to event_path(comment.event_id), notice: "コメントを削除しました。"
  end

  private
  def event_comment_params
    params.require(:event_comment).permit(:comment, :user_id, :event_id)
  end

  def non_active_user
    unless user_signed_in? && current_user.active?
      flash[:notice] = "アカウントがアクティブではありません"
      redirect_to '/'
    end
  end  
end