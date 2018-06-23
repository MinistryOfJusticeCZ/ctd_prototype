class CreateLayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :layouts do |t|
      t.string :name
      t.integer :format, default: 0

      t.timestamps
    end
  end
end
