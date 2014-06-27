class Major < ActiveRecord::Base
  has_many :options
  has_many :requirements
end
