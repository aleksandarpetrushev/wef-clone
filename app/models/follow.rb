class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  has_one :notification, dependent: :destroy
end
