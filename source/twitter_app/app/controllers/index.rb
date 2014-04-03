
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

# get '/' do
#   # Look in app/views/index.erb
#   erb :index
# end

# get '/bands' do
#   @band_names = Band.all.map(&:name)
#   erb :bands
# end

# post '/bands' do
#   new_band = Band.create!(name: params[:name])
#   redirect "/bands/#{new_band.id}"
# end

# get '/bands/new' do
#   erb :new_band
# end

# get '/bands/:id' do
#   @band = Band.find(params[:id])
#   erb :show_band
# end


# get '/info' do
#   Demo.new(self).info
# end
