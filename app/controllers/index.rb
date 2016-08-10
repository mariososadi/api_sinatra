get '/' do
  erb :index
end

post '/fetch' do

  if params[:handle] == "" 
    redirect '/'
  else 
    if User.find_by(handle: params[:handle]) == nil
      return 'A'
    elsif Tweets.updated?(params[:handle], User.find_by(handle: params[:handle]).id)
      @display = Tweets.all
      @user = User.find_by(handle: params[:handle])
      erb :tweets , :layout => false
    else 
      return 'B'
    end
  end

end

get '/:handle' do

  @handle = params[:handle]
  @user = User.find_by(handle: @handle)
  if @user == nil
    @user = User.new(handle: @handle)
    if @user.save
       @twitter_user = CLIENT.user_search(@user.handle)[0]
    end
  else
    @twitter_user = CLIENT.user_search(@user.handle)[0]
  end 

  @t = Tweets.find_by(user_id: @user.id)
  if @t == nil
    @tweets = CLIENT.user_timeline(@user.handle,  options = {:count => 10})
    @tweets.each { |x| Tweets.create(user_id: @user.id, tweet: x.full_text) }
    @display = Tweets.all
  end 

  if Tweets.updated?(@user.handle, @user.id)
    @display = Tweets.all 
  else
    @roberto = Tweets.where(user_id: @user.id)
    Tweets.destroy(@roberto.to_a)
    @tweets = CLIENT.user_timeline(@user.handle,  options = {:count => 10})
    @tweets.each { |x| Tweets.create(user_id: @user.id, tweet: x.full_text) }
    @display = Tweets.all
  end
  erb :tweets

end
