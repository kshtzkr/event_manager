class UserController < ApplicationController
	before_action :set_user, only: %i[ show edit update destroy ]

	# GET /users or /users.json
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1 or /users/1.json
  def show
  	render json: @user
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

      if @user.save
      	data = { data: @user, status: :created, message: "User was successfully created." }
        render :json => data
      else
      	data = { data: @user.errors, status: :unprocessable_entity }
        render :json => data
      end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
      if @user.update(user_params)
      	data = { data: @user, status: :ok, message: "User was successfully updated." }
        render :json => data
      else
      	data = { data: @user.errors, status: :unprocessable_entity }
        render :json => data
      end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    data = {status: :ok, message: "User was successfully destroyed." }
    render :json => data
  end


	private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :username, :phone)
    end
end
