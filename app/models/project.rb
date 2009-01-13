class Project < ActiveRecord::Base

  has_many :projects
  belongs_to :user
  has_many :works
  
  validates_presence_of :name, :status

end
