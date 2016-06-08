class AddBannerToPost < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :banner_url, :string
  end
end
