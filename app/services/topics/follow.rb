module Topics
  class Follow
    def initialize(user:, topic:)
      @user = user
      @topic = topic
    end

    def call
      ApplicationRecord.transaction do
        follow = @user.follows.create_or_find_by!(
          topic: @topic
        )

        return false unless follow.previously_new_record?

        Notification.create!(
          user: @user,
          follow: follow
        )

        AuditLog.create!(
          user: @user,
          action: "topic_followed",
          record: @topic
        )

        true
      end
    end
  end
end