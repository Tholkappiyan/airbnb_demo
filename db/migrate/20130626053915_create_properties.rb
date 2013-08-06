class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer  :user_id
      t.string   :prop_type
      t.integer  :rate
      t.datetime :avail_start
      t.datetime :avail_end
      t.string   :addr1
      t.string   :addr2
      t.string   :city
      t.string   :state
      t.string   :title
      t.string   :description

      t.timestamps
    end
  end
end
