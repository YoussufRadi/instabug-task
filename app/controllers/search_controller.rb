class SearchController < ApplicationController
    def search
        @messages = params[:q].nil? ? [] : Message.search("*"+params[:q]+"*")
        render json: { messages: @messages }
    end
end
