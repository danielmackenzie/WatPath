class Option < ActiveRecord::Base
  belongs_to :major
  has_many :requirements
end
