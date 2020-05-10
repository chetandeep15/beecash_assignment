class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_event, only: [:show, :attend, :unattend]

  def index
    @events = Event.all.order(created_at: :desc)
  end

  def show
    @users = @event.users
  end

  def attend
    booking = @event.bookings.create(user_id: current_user.id)
    if booking
      flash[:success] = "Attending Event"
      redirect_to event_path(@event)
    else
      flash[:alert] = booking.errors.full_messages.join('<br>')
      redirect_to event_path(@event)
    end

  end

  def unattend
    booking = @event.bookings.find_by(user_id: current_user.id)
    if booking.try(:destroy)
      flash[:success] = "Unattended Event"
      redirect_to event_path(@event)
    else
      flash[:alert] = booking.errors.full_messages.join('<br>')
      redirect_to event_path(@event)
    end
  end

  private
  def find_event
    @event = Event.find_by(id: params[:id]) if params[:id]
    unless @event.present?
      flash[:alert] = "Event not found"
      redirect_to root_path
    end
  end
end