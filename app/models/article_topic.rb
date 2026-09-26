class ArticleTopic < ApplicationRecord
  belongs_to :article
  belongs_to :topic

  validates :article_id, uniqueness: { scope: :topic_id }
end
