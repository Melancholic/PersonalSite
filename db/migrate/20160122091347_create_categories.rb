class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.string :description, null:false, default: ""
      t.integer :weight, null:false, default:50
      t.references :parent, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
