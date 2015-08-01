class Player < ActiveRecord::Base
  has_many :contracts
  has_many :season_stats
  has_many :boxscores
end
