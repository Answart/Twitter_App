get '/' do
  if current_user
    erb :user_page #logged in home page
  else
    erb :index #login/createaccount page
  end
end

post '/users/login' do
  @user = User.find_by_email(params[:email])
  if @user
   if @user.password == params[:password]
    session[:user_id] = @user.id
    @logged_in_user = current_user
      redirect '/'
    end
  end
  # what does this route do if user doesn't exist? you need to catch all cases
  # in your controllers.
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :profile
end

get '/follow/:id' do
  @user = User.all.find(params[:id])
  # there's no reason to set current_user to a variable. the helper method already
  # sets an instance variable called @logged_in_user! you can just use that
  # variable after calling current_user
  @logged_in_user = current_user
  # nice use of a model method. also a bang, since its destructive.
  @logged_in_user.follow!(@user)
  redirect "/users/#{@user.id}"
end

get '/unfollow/:id' do
  @user = User.all.find(params[:id])
  @logged_in_user = current_user
  @logged_in_user.unfollow!(@user)
  redirect "/users/#{@user.id}"
end

post '/users/new' do
  @user = User.new(params)
  @user.password = params[:password]
  # try to avoid using the save bang method, since it will kill your program
  # if it fails. That's not great! the non-banged version will not do that. and then you can run sane control flow.
  # if @user.save
  #  # redirect to the page!
  #  else
  #   #redirect with errors!
  # end
  session[:user_id] = @user.id
  redirect to '/'
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end

post '/tweets/new' do
  Tweet.create(params)
  redirect '/'
end

get '/search/' do
  @search_term = params[:user_name]
  # find_by(:username ...) should do the trick here.
  user_name = "%" + params[:user_name] + "%"
  @potential_users = User.where('user_name like ?', user_name )
  p @search_term
  erb :search
end


get "/tweets/:id/retweets" do
  @og_tweet = Tweet.find(params[:id])
  # you can you associational creation to solve this problem.
  # @og_tweet.retweets.new()
  # you may need to adjust your models to get this working.
  @retweet = Tweet.new({
    :message => @og_tweet.message,
    :user => current_user,
    # you should try to avoid manually setting foreign keys.
    # Active Record can do that for you!
    :retweet_id => @og_tweet.id
    })
  @retweet.save!
  redirect "/"
end
