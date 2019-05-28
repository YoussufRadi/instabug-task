class ChatsController < ApplicationController
  before_action :authorize_request
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    @chats = Chat.find_by(user: @current_user)
    render json: @chats
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  # POST /chats
  def create
    @chat = @current_user.chats.create()
    if @current_user.save
      render json: @chat, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(:user_id => @current_user.id)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find_by(id: params[:id], user: @current_user)
      if !@chat
        render json: { errors: 'Chat not found' }, status: :not_found
      end
    end

    # Only allow a trusted parameter "white list" through.
    # def chat_params
    #   puts @current_user.id
    #   params[:user_id] = @current_user.id
    #   puts params
    # end
end
