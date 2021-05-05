class EventsController < ApplicationController
  skip_before_action :authenticate, only: :show

  def show
    @event = Event.find(params[:id])
    @ticket = current_user && current_user.tickets.find_by(event: @event)
    @tickets = @event.tickets.includes(:user).order(:created_at)
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event, notice: "Event created."
    end
  end

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  def update
    @event = current_user.created_events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "Update successfully."
    end
  end

  # By using the `destroy!` method instead of the `destroy` method, RecordNotDestroyed will be raised when the deletion is aborted by a hook method called at the time of deletion.
  # `destroy` メソッドではなく `destroy!` メソッドを利用することで、削除時に呼ばれるフックメソッドで削除を中断するなどした場合に RecordNotDestroyed を raise させる。
  def destroy
    @event = current_user.created_events.find(params[:id])
    @event.destroy!
    redirect_to root_path, notice: "Event deletion completed."
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :place, :image, :remove_image, :content, :start_at, :end_at
    )
  end
end
