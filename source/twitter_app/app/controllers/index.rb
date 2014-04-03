
get '/' do
  if current_user
    # @user = current_user
    erb :user_page #logged in home page
  else
    erb :index #login/createaccount page
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :user_profile
end

post '/users/login' do
  @user = User.find_by_email(params[:email])  #add unique constrain to migration
  p "_______________________________________"
  p @user
  if @user
     if @user.password == params[:password]
      session[:user_id] = @user.id
      @user
      erb :user_profile
    end

  end
  redirect to '/'
end

post '/users/new' do
  User.create(params)
  redirect to '/'
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end

post '/tweets/new'
  Tweet.create(params)
end