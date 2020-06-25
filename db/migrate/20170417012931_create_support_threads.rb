class CreateSupportThreads < ActiveRecord::Migration[4.2]
  def change
    create_table :support_threads do |t|
      t.references :support_category, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title, null: false
      t.string :slug, null: false
      t.integer :support_posts_count, default: 0
      t.integer :like_count, default: 0
      t.integer :dislike_count, default: 0
      t.boolean :pinned, default: false
      t.boolean :solved, default: false
      t.integer  :position, default: 0

      t.timestamps
    end
  end
end
