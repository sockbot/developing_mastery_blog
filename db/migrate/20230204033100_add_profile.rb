class AddProfile < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :handle
      t.integer :icq      
      t.timestamps
      t.references :user
    end
  end
end
