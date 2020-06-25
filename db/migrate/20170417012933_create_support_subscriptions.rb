class CreateSupportSubscriptions < ActiveRecord::Migration[4.2]
  def change
    create_table :support_subscriptions do |t|
      t.references :support_thread, foreign_key: true
      t.references :user, foreign_key: true
      t.string   :subscription_type

      t.timestamps
    end
  end
end
