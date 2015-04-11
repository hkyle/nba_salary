class Contract < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  scope :year, lambda{|y| where("year IN (?)", y )}
  
end
