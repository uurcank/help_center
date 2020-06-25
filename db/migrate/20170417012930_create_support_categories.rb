class CreateSupportCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :support_categories do |t|
      t.string   :name, null: false
      t.string   :slug, null: false
      t.string   :color, default: "000000"
      t.integer  :position, default: 0

      t.timestamps
    end

    SupportCategory.reset_column_information

    SupportCategory.create(
      name: "Getting Started",
      color: "#4ea1d3",
    )
  end
end
