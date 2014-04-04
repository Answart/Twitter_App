class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :user
      t.string :message
      t.integer :retweet_id, default: nil

      t.timestamps
    end
  end
end
