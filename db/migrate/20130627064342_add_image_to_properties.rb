class AddImageToProperties < ActiveRecord::Migration
  def change
  	add_column :properties, :image_file_name,    :string
  	add_column :properties, :image_content_type, :string
  	add_column :properties, :image_file_size,    :integer
  	add_column :properties, :image_updated_at,   :datetime
  end
end
