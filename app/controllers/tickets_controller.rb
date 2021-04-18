class TicketsController < ApplicationController
  def new
    raise ActionController::RoutingError, "Accessed TicketsController#new in logged-in state"
  end

  def create
    event = Event.find(params[:event_id])
    @ticket = current_user.tickets.build do |t|
      t.event = event
      t.comment = params[:ticket][:comment]
    end
    if @ticket.save
      redirect_to event, notice: "You joined this Event."
    end
  end

  def destroy
    puts params
    ticket = current_user.tickets.find_by!(event_id: params[:event_id])
    ticket.destroy!
    redirect_to event_path(params[:event_id]), notice: "Cancel your participation of this Event is completed."
  end
end
