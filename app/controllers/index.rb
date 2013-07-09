get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
    
  @user = TwitterUser.find_or_create_by_username(params[:username])
    
  @user.fetch_tweets!
  
  @tweets = @user.tweets.limit(10)
  
  erb :list
end

post '/username' do
  @username = params[:username]
  twitter_obj = Twitter.user(@username)
  current_user = TwitterUser.find_or_create_by_twitter_handle_and_user_id(@username, twitter_obj[:id].to_s)
  
  if current_user.tweets_stale?
    user_timeline = Twitter.search("from: #{@username} -rt", :count => 10)
    user_timeline[:statuses].each_with_index do |tweet, i|
      Tweet.create(tweet_content: tweet[:text], twitter_user_id: current_user.id, sent_at: tweet[:created_at], twitters_id: tweet[:id].to_s)
    end
  end

  if current_user.tweets.count < 10
    @current_tweets = current_user.tweets
  else
    @current_tweets = current_user.tweets[-10..-1]
  end

  erb :_recent_tweets, :layout => false
end

