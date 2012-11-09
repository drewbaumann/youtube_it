class YouTubeIt
  module Request #:nodoc:
    class TemporalMetrics #:nodoc:

      include YouTubeIt::Logging

      def initialize *params
        @end_date = params[:endDate]
        @views = params[:views]
        @comments = params[:comments]
        @favorites_added = params[:favoritesAdded]
        @favorites_removed = params[:favoritesRemoved]
        @likes = params[:likes]
        @dislikes = params[:dislikes]
        @shares = params[:shares]
        @subscribers_gained = params[:subscribersGained]
        @subscribers_lost = params[:subscribersLost]
        @uniques = params[:uniques]
      end

    end
  end
end