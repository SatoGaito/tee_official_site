class EventCalendersController < ApplicationController

  before_action :ensure_correct_user, except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @event_calenders = EventCalender.all
  end

  def new
    @event_calender = EventCalender.new
  end

  def show
    @event_calender = EventCalender.find(params[:id])
  end

  def create
    @event_calender = EventCalender.new(event_calender_parameter)
    if @event_calender.save
      redirect_to event_calender_path(@event_calender), notice: "活動の投稿を完了しました。"
    else
      render :new
    end
  end

  def destroy
    @event_calender = EventCalender.find(params[:id])
    @event_calender.destroy
    redirect_to event_calenders_path, notice:"活動を削除しました"
  end

  def edit
    @event_calender = EventCalender.find(params[:id])
  end

  def update
    @event_calender = EventCalender.find(params[:id])
    if @event_calender.update(event_calender_parameter)
      redirect_to event_calender_path(@event_calender), notice: "活動を編集しました"
    else
      render 'edit'
    end
  end

  private

  def event_calender_parameter
    params.require(:event_calender).permit(:title, :content, :start_time)
  end

  def ensure_correct_user
    unless user_signed_in? && current_user.executive?
      flash[:notice] = "権限がありません"
      redirect_to '/'
    end
  end

end