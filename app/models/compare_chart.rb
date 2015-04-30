class CompareChart < Chart
  attr_reader :stat
  
  def initialize(params)
    super
    @contracts = Contract.year(@year).where(team_id: teams.map{|t| t.id})
  end
  
  def teams
      Team.teams(@teams_arr).sort_by{|t| @teams_arr.flatten.index(t.abbr)} #keep them in the params' order
  end
  
  def main_chart
      'bar'
  end

end