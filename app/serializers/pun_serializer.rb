class PunSerializer < ActiveModel::Serializer
  attributes :id, :tweet, :is_published, :publication_date, :tweet_id
end
