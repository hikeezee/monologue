class AddCategoryAndDescriptionToPost < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :category_cd, :integer
    add_column :monologue_posts, :description, :string
  end
end
