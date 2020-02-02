class EventsController < ApplicationController

  before_action :ensure_correct_user, except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.user_id = current_user.id
    event.save
    redirect_to events_path
  end

  def show
    @event = Event.find(params[:id])
    @event_comment = EventComment.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event.update(event_params)
    # event.user_id = current_user.id
    redirect_to event_path(event)
  end

  def destroy
    event = Event.find(params[:id])
    event.delete
    redirect_to events_path
  end

  private
  def event_params
    params.require(:event).permit(:title, :date, :content, :event_image)
  end

  def ensure_correct_user
    unless user_signed_in? && current_user.admin?
      flash[:notice] = "権限がありません"
      redirect_to events_path
    end
  end
end