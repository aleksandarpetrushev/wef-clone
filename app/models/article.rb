class Article < ApplicationRecord
  has_many :article_topics, dependent: :destroy
  has_many :topics, through: :article_topics

  scope :for_followed_topics, ->(user) {
    joins(:article_topics)
      .where(article_topics: { topic_id: user.follows.select(:topic_id) })
      .distinct
  }

  scope :newest_first, -> { order(created_at: :desc) }
end
