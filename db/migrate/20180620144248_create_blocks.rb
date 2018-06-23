class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.string :name
      t.string :path
      t.string :format, default: 0
      t.text :variables

      t.timestamps
    end
  end
end
