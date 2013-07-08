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
