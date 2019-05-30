class MessagesController < ApplicationController
  before_action :authorize_request
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    @messages = Message.where(chat: @chat).all
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
    # @message = @chat.messages.create(message_params_create)
    @ins = message_params_create
    if !params[:body].present?
      render json: {"error": "Body cannot be empty"}, status: :unprocessable_entity
    else
      MessageCreateWorker.perform_async(@chat.id,  @ins[:message_number], @ins[:body])
      render json: {
                "body": @ins[:body],
                "message_number": @ins[:message_number],
                "chat_number": @chat.chat_number,
                }, status: :created
      end
    # if @message.save
    #   render json: @message, status: :created
    # else
    #   render json: @message.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /messages/1
  def update
    @ins = message_params_update
    if !params[:body].present?
      render json: {"error": "Body cannot be empty"}, status: :unprocessable_entity
    else
      MessageUpdateWorker.perform_async(@message.id, @ins[:body])
      render json: {
                "body": @ins[:body],
                "message_number": @message.message_number,
                "chat_number": @chat.chat_number,
                }
    end
    # if @message.update(message_params_update)
    #   render json: @message
    # else
    #   render json: @message.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private

    def set_chat
      @chat = Chat.find_by(chat_number: params[:chat_id], user: @current_user)
      if !@chat
        render json: { errors: 'Chat not found' }, status: :not_found
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find_by(message_number: params[:id], chat: @chat)
      if !@message
        render json: { errors: 'Message not found' }, status: :not_found
      end
      # @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params_create
      @message_number = Slug.inc("chat_id"+@chat.id.to_s)
      params.permit(:body).merge(message_number: @message_number)
    end

    def message_params_update
      params.permit(:body)
    end
end
