class CreateContexts < ActiveRecord::Migration[5.2]
  def change
    create_table :contexts do |t|
      t.string :name
      t.string :ancestry, index:true
      t.text :variables

      t.timestamps
    end
  end
end
