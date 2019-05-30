class SearchController < ApplicationController
    def search
        @query  = "chat_id:" + params[:chat_id] + " AND body:*"
        @messages = params[:body].nil? ? [] : Message.search(@query + params[:body] + "*")
        render json: { messages: @messages }
    end
end
