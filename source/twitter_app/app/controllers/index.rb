get '/' do
  #welcome page
  #if logged in -- redirect to '/users'
  #else login
  # if loggedin?
  #   erb :index
  # else
  #   redirect '/login'
  # end
  # what info displayed on view?
  erb :index
end


get '/users/new' do
  @user = User.create(params)
  erb :new_user
end

get '/users/:id' do
  @band = Band.find(params[:id])
  erb :show_band
end

# get '/info' do
#   Demo.new(self).info
# end
