class Topic < ApplicationRecord
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user

  has_many :article_topics, dependent: :destroy
  has_many :articles, through: :article_topics
end
