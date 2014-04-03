helpers do
  def loggedin?
    !!sessions[:id]
  end
end
