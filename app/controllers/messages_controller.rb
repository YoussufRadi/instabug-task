class MessagesController < ApplicationController
  before_action :authorize_request
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    @messages = Message.find_by(chat: @chat)
    if !@chat
      render json: { errors: 'Chat not found' }, status: :not_found
    else
      render json: @messages
    end 
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    puts params
    puts message_params
    @message = @chat.messages.create(message_params)
    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private

    def set_chat
      @chat = Chat.find_by(id: params[:chat_id], user: @current_user)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      if !@chat
        render json: { errors: 'Chat not found' }, status: :not_found
      end
      if !@message
        render json: { errors: 'Message not found' }, status: :not_found
      end
      @message = Message.find_by(id: params[:id], chat: @chat)
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.permit(:body)
    end
end
