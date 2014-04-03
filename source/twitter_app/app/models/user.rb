class User < ActiveRecord::Base
  has_many :tweets
  # Remember to create a migration!
  include BCrypt

  def password
      @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      @user
    else
      return nil
    end
  end

  # def followers
  #   @followers = Relationship.where('followed_id = ?' self.id)
  # end

  # def following
  #   @following = Relationship.where('follower_id = ?' self.id)
  # end
end
