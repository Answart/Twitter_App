
get '/' do
  if loggedin?
    erb :user_page #logged in home page
  else
    erb :index #login/createaccount page
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :user_profile
end

post 'users/login' do
  @user = User.find_by_email(email: params[:email])  #add unique constrain to migration
  if @user
     if @user.password == params[:password]
      session[:user_id] = @user.id
      erb :user_profile
    end
  end
  redirect to '/'
end

post '/users/new' do
  User.create(params)
  redirect to '/'
end