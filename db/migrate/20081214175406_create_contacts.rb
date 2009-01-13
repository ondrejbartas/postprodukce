class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.string :note
      t.boolean :invoice
      t.boolean :deleted
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
