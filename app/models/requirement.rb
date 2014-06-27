class Requirement < ActiveRecord::Base
  belongs_to :major
  belongs_to :option
  has_and_belongs_to_many :courses
end
