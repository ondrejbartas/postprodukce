class CreateJobTypes < ActiveRecord::Migration
  def self.up
    create_table :job_types do |t|
      t.string :name
      t.string :note
      t.string :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :job_types
  end
end
