class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :identity_card
      t.text :address
      t.string :contact
      t.decimal :balance

      t.timestamps
    end
  end
end
