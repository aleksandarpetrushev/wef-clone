class User < ApplicationRecord
  has_many :follows, dependent: :destroy
  has_many :followed_topics, through: :follows, source: :topic
  has_many :feed_articles, -> { distinct }, through: :followed_topics, source: :articles
end
