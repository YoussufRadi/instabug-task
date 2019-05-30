class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :set_user, only: [:index, :update, :destroy]

  # GET /users
  # def index
  #   @users = User.all
  #   render json: @users, status: :ok
  # end

  # GET /users
  def index
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if !params[:name].present?
      render json: {"error": "Name cannot be empty"}, status: :unprocessable_entity
    else
      begin
        puts "test"
        @user.save!
        render json: @user, status: :created, location: @user
      rescue ActiveRecord::RecordNotUnique => e
        render json: {"error": "Name is already taken"}, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if @current_user
        @user = @current_user 
      else
        @user = User.find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:name)
    end
end
