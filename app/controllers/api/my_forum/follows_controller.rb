module Api
  module MyForum
    class FollowsController < Api::BaseController
      def create
        topic = Topic.find(params[:topic_id])

        ApplicationRecord.transaction do
          Topics::Follow.new(current_user, topic).call
        end

        FollowNotificationJob.perform_later(current_user.id, topic.id)

        head :no_content
      rescue ActiveRecord::RecordNotUnique
        head :no_content
      end
    end
  end
end
