class YouTubeIt
  module Request #:nodoc:
    class ChannelAnalytics #:nodoc:

      include YouTubeIt::Logging

      def initialize *params
        if params.first.is_a?(Hash)
          hash_options = params.first
          @user                          = hash_options[:username]
          @password                      = hash_options[:password]
          @dev_key                       = hash_options[:dev_key]
          @access_token                  = hash_options[:access_token]
          @authsub_token                 = hash_options[:authsub_token]
          @client_id                     = hash_options[:client_id] || "youtube_it"
          @config_token                  = hash_options[:config_token]
        else
          puts "* warning: the method YouTubeIt::Upload::VideoUpload.new(username, password, dev_key) is deprecated, use YouTubeIt::Upload::VideoUpload.new(:username => 'user', :password => 'passwd', :dev_key => 'dev_key')"
          @user                          = params.shift
          @password                      = params.shift
          @dev_key                       = params.shift
          @access_token                  = params.shift
          @authsub_token                 = params.shift
          @client_id                     = params.shift || "youtube_it"
          @config_token                  = params.shift
        end
      end

      def get_analytics(opts)
        # max_results = opts[:per_page] || 50
        # start_index = ((opts[:page] || 1) -1) * max_results +1
        get_url     = "/youtube/analytics/v1/reports?"
        get_url     << opts.collect { |k,p| [k,p].join '=' }.join('&')
        response    = yt_session().get(get_url)

        return YouTubeIt::Parser::AnalyticsParser.new(response.body).parse
      end

      private

      def base_url
        'https://www.googleapis.com'
      end

      def authorization_headers
        header = {"X-GData-Client"  => "#{@client_id}"}
        header.merge!("X-GData-Key" => "key=#{@dev_key}") if @dev_key
        if @authsub_token
          header.merge!("Authorization"  => "AuthSub token=#{@authsub_token}")
        elsif @access_token.nil? && @authsub_token.nil? && @user
          header.merge!("Authorization"  => "GoogleLogin auth=#{auth_token}")
        end
        header
      end

      def yt_session(url = nil)
        Faraday.new(:url => (url ? url : base_url), :ssl => {:verify => false}) do |builder|
          if @access_token
            if @config_token
              builder.use Faraday::Request::OAuth, @config_token
            else
              builder.use Faraday::Request::OAuth2, @access_token
            end
          end
          builder.use Faraday::Request::AuthHeader, authorization_headers
          builder.use Faraday::Response::YouTubeIt
          builder.adapter YouTubeIt.adapter

        end
      end
    end
  end
end