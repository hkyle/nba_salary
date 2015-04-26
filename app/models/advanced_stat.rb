class AdvancedStat < ActiveRecord::Base
  belongs_to :player
  scope :year, lambda{|y| where("year IN (?)", y )}
  
end
