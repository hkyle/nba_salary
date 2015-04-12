class Team < ActiveRecord::Base
  has_many :contracts, class_name: "Contract", foreign_key: "team_id"
end
