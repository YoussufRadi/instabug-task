require 'elasticsearch/model'

class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  validates :body, presence: true
  belongs_to :chat

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :body, analyzer: 'english'
      indexes :chat_id, type: 'integer'
    end
  end

#   def self.search(query)
#   __elasticsearch__.search(
# {
#   "query": {
#     "query_string": {
#       "default_field": "q",
#       "query": "body:first"
#     }
#   }
# }
#   )
#   end

end

# Delete the previous messages index in Elasticsearch
Message.__elasticsearch__.client.indices.delete index: Message.index_name rescue nil

# Create the new index with the new mapping
Message.__elasticsearch__.client.indices.create \
  index: Message.index_name,
  body: { settings: Message.settings.to_hash, mappings: Message.mappings.to_hash }

Message.import(force: true)
