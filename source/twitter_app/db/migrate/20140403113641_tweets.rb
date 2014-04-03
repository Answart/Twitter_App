class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :user
      t.string :message

      t.timestamps
    end
  end
end
