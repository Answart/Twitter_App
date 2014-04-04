
get '/' do
  if current_user
    # @user = current_user
    erb :user_page #logged in home page
  else
    erb :index #login/createaccount page
  end
end

post '/users/login' do
  @user = User.find_by_email(params[:email])
  # p "___________________________________________"
  # p @user
  #   p "___________________________________________"
  if @user
     if @user.password == params[:password]
      session[:user_id] = @user.id
      @logged_in_user = current_user
      # p "Password is correct"
     redirect '/'
    end

  end
  # redirect to '/'
end

get '/users/:id' do
  @user = User.find(params[:id])

  erb :profile
end

get '/follow/:id' do
  @user = User.all.find(params[:id])
  @logged_in_user = current_user
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
  @user.save!
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