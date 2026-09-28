module Api
  module MyForum
    class FollowsController < Api::BaseController
      def create
        topic = Topic.find(params[:topic_id])

        created = Topics::Follow.new(user: current_user, topic: topic).call

        FollowNotificationJob.perform_later(current_user.id, topic.id) if created

        head :no_content
      end
    end
  end
end
