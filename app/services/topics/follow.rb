module Topics
  class Follow
    def initialize(user, topic)
      @user = user
      @topic = topic
    end

    def call
      follow = @user.follows.create!(topic: @topic)

      Notification.create!(
        user: @user,
        follow: follow
      )

      AuditLog.create!(
        user: @user,
        action: "topic_followed",
        record: @topic
      )
    end
  end
end
