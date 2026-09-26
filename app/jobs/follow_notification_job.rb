class FollowNotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id, topic_id)
    # Placeholder for async follow notification side effects
  end
end
