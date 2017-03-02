class MigrateAndDeleteCategoryOnPosts < ActiveRecord::Migration
  def change
    Monologue::Post.all.each do |post|
      post_categories = {"N/A" => 0}.invert
      post.category_list = post_categories[post.category_cd].to_s
      post.save(validate: false)
    end

    remove_column :monologue_posts, :category_cd
  end
end
