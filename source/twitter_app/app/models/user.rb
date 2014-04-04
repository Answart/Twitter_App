class User < ActiveRecord::Base
  has_many :tweets
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :relationships, source: :follower

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

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  def self.followers(user_id)
    @followers = Relationship.where('followed_id = ?', user_id)
    # puts "=" * 20
    # p @followers

    display_followers
  end
  def self.display_followers
    @users_followers = []
    @followers.each do |my_follower|
      @users_followers << User.find(my_follower.follower_id)
    end
    @users_followers
  end

  # def following
  #   @following = Relationship.where('follower_id = ?' self.id)
  # end
end
