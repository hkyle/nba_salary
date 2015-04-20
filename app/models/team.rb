class Team < ActiveRecord::Base
  has_many :contracts, class_name: "Contract", foreign_key: "team_id"
  scope :teams, lambda{|y| where("abbr IN (?)", y )}
end
