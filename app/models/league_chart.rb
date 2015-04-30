class LeagueChart < Chart
  
  def teams
      Team.all.order(:abbr)
  end
  
  def main_chart
      'column'
  end
  
  def drill_chart
      'pie'
  end
  
end