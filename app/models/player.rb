class Player < ActiveRecord::Base
  has_many :contracts
  has_many :advanced_stats
  has_many :boxscores
end
