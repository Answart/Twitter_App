enable :sessions

get '/' do
  if loggedin?
    erb :user_page #logged in home page
  else
    erb :index #login/createaccount page
end

get '/user/:id' do
  @user = User.find(params[:id])
  erb :user_profile
end

post 'user/login' do
  @user = User.find_by_email(email: params[:email])  #add unique constrain to migration
  if @user
     if @user.password == params[:password]
      session[:id] = @user.id
      erb :user_profile
    end
  end
  redirect to '/'
end


