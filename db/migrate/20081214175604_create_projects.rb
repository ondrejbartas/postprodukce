class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :status
      t.string :note
      t.timestamp :creationDate
      t.timestamp :finishDate
      t.boolean :deleted
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
