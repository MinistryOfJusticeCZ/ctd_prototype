class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :name
      t.references :layout
      t.references :context
      t.integer :format, default: 0

      t.timestamps
    end
  end
end
