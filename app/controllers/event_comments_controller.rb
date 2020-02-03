class EventCommentsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    if user_signed_in?
      comment = current_user.event_comments.new(event_comment_params)
      comment.event_id = event.id
      comment.save
      redirect_to event_path(event)
    end
  end

  def destroy
    comment = EventComment.find_by(id: params[:id], event_id: params[:event_id])
    comment.delete
    redirect_to event_path(comment.event_id)
  end

  private
  def event_comment_params
    params.require(:event_comment).permit(:comment, :user_id, :event_id)
  end
end