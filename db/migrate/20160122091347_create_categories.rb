class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.string :description
      t.integer :weight, null:false, default:0
      t.references :parrent, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
