class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.string :name
      t.string :status
      t.string :note
      t.timestamp :startDate
      t.timestamp :endDate
      t.boolean :deleted

      t.integer :user_id
      t.integer :project_id
      t.integer :place_id
      t.integer :job_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :works
  end
end
