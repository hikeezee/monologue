class CreateMonologueCategories < ActiveRecord::Migration
  def change
    create_table :monologue_categories do |t|
      t.string :name
      t.string :url_id
    end
    add_index :monologue_categories, :name
    add_index :monologue_categories, :url_id

    create_table :monologue_categorizations do |t|
      t.integer :post_id, :category_id
    end

    add_index :monologue_categorizations, :post_id
    add_index :monologue_categorizations, :category_id
  end
end
