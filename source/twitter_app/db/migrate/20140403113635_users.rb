class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, unique: true
      t.string :name
      t.string :password_hash
      t.string :email, unique: true

      t.timestamps
    end
  end
end
