class EventsController < ApplicationController
  # before_action :require_login, except: [:new]
  def index
    @your_events = Event.where(state:User.find(session[:user_id]).state)
    @other_events = Event.where.not(state:User.find(session[:user_id]).state)
    @event = Event.new
  end
  def show
    @event = Event.find(params[:id])
    @comments = Comment.where(event_id:params[:id])
    @comment = Comment.new
  end
  def create
      event = Event.new(events_params)
    if event.save
      # session[:user_id] = user.id
      redirect_to '/events'
      flash[:notice] = "Your event has been created successfully!"
    else
      redirect_to '/events'
      flash[:errors] = event.errors.full_messages
    end
  end
  def edit
      @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(events_params)
      flash[:notice] = "Your event has been updated successfully!"
    else
      flash[:errors] = @event.errors.full_messages
    end
    redirect_to "/events/#{@event.id}/edit"
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to '/events'
  end

  private
  def events_params
      params.require(:event).permit(:name, :date, :location, :state, :user_id)
  end
end
