class AddTitleToPost < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string, default: "no title"
  end
end
