class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :persistence_token
      t.string :crypted_password

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
