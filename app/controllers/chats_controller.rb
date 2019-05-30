class ChatsController < ApplicationController
  before_action :authorize_request
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    @chats = Chat.where(user: @current_user).all
    render json: @chats
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  # POST /chats
  def create
    @ins = chat_params
    ChatCreateWorker.perform_async(@current_user.id,  @ins[:chat_number])
    if(@ins[:chat_number] %10 == 0)
      ChatsCounterWorker.perform_async(@current_user.id,  @ins[:chat_number])
    end
    # @chat = @current_user.chats.create(@ins)
    # if @chat.save
    # else
    #   render json: @chat.errors, status: :unprocessable_entity
    # end
    render json: {
                  "user_id": @current_user.id,
                  "messages_count": 0,
                  "chat_number": @ins[:chat_number],
                  }, status: :created, location: @chat
  end

  # PATCH/PUT /chats/1
  # def update
  #   if @chat.update(:user_id => @current_user.id)
  #     render json: @chat
  #   else
  #     render json: @chat.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find_by(chat_number: params[:id], user: @current_user)
      if !@chat
        render json: { errors: 'Chat not found' }, status: :not_found
      end
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      @chat_number = Slug.inc("user_id"+@current_user.id.to_s)
      params.permit().merge(chat_number: @chat_number)
    end
end
