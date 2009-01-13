class Place < ActiveRecord::Base
  has_many :works
  validates_presence_of :name


end
