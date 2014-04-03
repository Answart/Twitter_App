class Relationship < ActiveRecord::Base
  belongs_to :followed_id
  belongs_to :follower_id
end
