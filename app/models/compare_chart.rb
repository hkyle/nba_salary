class CompareChart < Chart
  
  def teams_arr
    @teams
  end
  
  def teams
      Team.teams(@teams)
  end
  
  def main_chart
      'bar'
  end
  
  def drill_chart
      'pie'
  end
end