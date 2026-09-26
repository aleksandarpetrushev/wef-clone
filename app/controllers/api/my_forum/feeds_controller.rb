module Api
  module MyForum
    class FeedsController < Api::BaseController
      PER_PAGE = 20

      def show
        articles = feed_scope
          .preload(:topics)
          .newest_first
          .limit(PER_PAGE)
          .offset(offset)

        render json: {
          data: articles.as_json(include: :topics),
          meta: {
            page: page,
            per_page: PER_PAGE,
            total_count: feed_scope.count
          }
        }
      end

      private

      def feed_scope
        Article.for_followed_topics(current_user)
      end

      def page
        @page ||= [params.fetch(:page, 1).to_i, 1].max
      end

      def offset
        (page - 1) * PER_PAGE
      end
    end
  end
end
