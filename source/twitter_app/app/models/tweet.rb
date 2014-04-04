class Tweet < ActiveRecord::Base
  belongs_to :user
  validates :message, length: { maximum: 140 }

  # Remember to create a migration!
end
