class Contract < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  scope :year, lambda{|y| where("year IN (?)", y )}
  
  def self.salary_cap(year)
    case year
    when '2014-2015'
      [63065000, 76829000]
    when '2015-2016'
      [70000000, 84740000]
    end
  end
  
end
