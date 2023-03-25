class CreateCeos < ActiveRecord::Migration[7.0]
  def change
    create_table :ceos do |t|
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
