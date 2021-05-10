class CreateSupportPosts < ActiveRecord::Migration[4.2]
  def change
    create_table :support_posts do |t|
      t.references :support_thread, foreign_key: true
      t.references :user, foreign_key: true
      t.text     :body
      t.boolean  :solved, default: false

      t.timestamps
    end
  end
end
