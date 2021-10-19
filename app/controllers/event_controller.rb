class EventController < ApplicationController
	before_action :set_event, only: %i[ update destroy ]

	# GET /event or /event.json
  def index
    @event = Event.all
    render json: @event
  end

  # GET /event/1 or /event/1.json
  def show
  	render json: @event
  end

  # POST /event or /event.json
  def create
    @event = Event.new(event_params)

      if @event.save
      	data = { data: @event, status: :created, message: "Event was successfully created." }
        render :json => data
      else
      	data = { data: @event.errors, status: :unprocessable_entity }
        render :json => data
      end
  end

  # PATCH/PUT /event/1 or /event/1.json
  def update
      if @event.update(event_params)
      	data = { data: @event, status: :ok, message: "Event was successfully updated." }
        render :json => data
      else
      	data = { data: @event.errors, status: :unprocessable_entity }
        render :json => data
      end
  end

  # DELETE /event/1 or /event/1.json
  def destroy
    @event.destroy
    data = {status: :ok, message: "Event was successfully destroyed." }
    render :json => data
  end


	private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :start_time, :end_time, :description, :all_day)
    end

end
