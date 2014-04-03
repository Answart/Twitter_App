helpers do
  def loggedin?
    !!sessions[:user_id]
  end
end
