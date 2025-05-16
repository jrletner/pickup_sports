class EventsController < ApplicationController
  before_action :set_event, only: [ :update, :delete, :show ]
  before_action :authenticate_request

  def create
    event = Event.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def index
    events = event.all
    render json: events, status: :ok
  end

  def show
    render json: @event, status: :ok
  end

  def update
    if @event.update(event_params)
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def delete
    if @event.destroy
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private
  def set_event
    @event = event.find(params[:id])
  end

  def event_params
    params.permit(:content, :user_id, :start_date_time, :end_date_time)
  end
end
