class YouTubeIt
  module Request #:nodoc:
    class TemporalMetrics #:nodoc:

      include YouTubeIt::Logging

      def initialize *params
        @end_date = params[:end_date]
        @views = params[:views]
        @comments = params[:comments]
        @favorites_added = params[:favorites_added]
        @favorites_removed = params[:favorites_removed]
        @likes = params[:likes]
        @dislikes = params[:dislikes]
        @shares = params[:shares]
        @subscribers_gained = params[:subscribers_gained]
        @subscribers_lost = params[:subscribers_lost]
        @uniques = params[:uniques]
      end

    end
  end
end