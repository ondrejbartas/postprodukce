class Work < ActiveRecord::Base

  belongs_to :project
  belongs_to :user
  belongs_to :job_type
  belongs_to :place
  
  validates_presence_of :startDate, :project
end
