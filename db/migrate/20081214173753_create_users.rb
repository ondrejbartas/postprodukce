class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :limit => 40
      t.string :login, :limit => 40
      t.string :password, :limit => 40
      t.integer :role
      t.boolean :deleted
      t.timestamps
    end

    User.create (:name => "admin", :login => "admin", :password_new => "admin", :password => "admin", :role => 15015)
  end

  def self.down
    drop_table :users
  end
end
