class YouTubeIt
  module Model
    class Channel < YouTubeIt::Record
      attr_reader :views
      attr_reader :uniques
      attr_reader :viewerPercentage
      attr_reader :comments
      attr_reader :favoritesAdded
      attr_reader :favoritesRemoved
      attr_reader :likes
      attr_reader :dislikes
      attr_reader :shares
      attr_reader :subscribersGained
      attr_reader :subscribersLost
    end
  end
end