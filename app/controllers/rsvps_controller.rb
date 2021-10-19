class RsvpsController < ApplicationController
	before_action :set_rsvps, only: %i[ update ]

	def create
		@rsvp = Rsvp.new(rsvp_params)
		find_rsvps = Rsvp.where(user_id: rsvp_params[:user_id])


		if find_rsvps
			event_ids = find_rsvps.pluck(:event_id)
			events = Event.where(id: event_ids)
			check_overlapping(events)
			@rsvp.status = "no" if @arr.include?(true)
		end

		if @rsvp.save
			data = { data: @rsvp, status: :created, message: "Rsvp was successfully created." }
			render :json => data
		else
			data = { data: @rsvp.errors, status: :unprocessable_entity }
			render :json => data
		end
	end

	def update
	  if @rsvp.update(rsvp_params)
	  	data = { data: @rsvp, status: :ok, message: "Rsvp was successfully updated." }
	    render :json => data
	  else
	  	data = { data: @rsvp.errors, status: :unprocessable_entity }
	    render :json => data
	  end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsvps
      @rsvp = Rsvp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rsvp_params
      params.require(:rsvp).permit(:user_id, :event_id, :status)
    end

    def check_overlapping(events)
    	now = Event.find(rsvp_params[:event_id]).start_time
    	@arr = []
    	events.each do |event|
			start = event.start_time
			stop =  event.end_time
			@arr << (start..stop).cover? now
		end
    end
end
