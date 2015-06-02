class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text   :body, defualt: "no content"
      t.string :author_name, default: "anonymous"

      t.timestamps
    end
  end
end
