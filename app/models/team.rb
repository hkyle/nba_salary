class Team < ActiveRecord::Base
  has_many :contracts, class_name: "Contract", foreign_key: "team_id"
  has_many :home_games, class_name: "Game", foreign_key: "home_team_id"
  has_many :away_games, class_name: "Game", foreign_key: "away_team_id"
  has_many :boxscores, class_name: "Boxscore", foreign_key: "team_id"
  
  scope :teams, lambda{|y| where("abbr IN (?)", y )}
end
