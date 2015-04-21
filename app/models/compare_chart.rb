class CompareChart < Chart
  
  def initialize(params)
    super
    @contracts = Contract.year(@year).where(team_id: teams.map{|t| t.id})
  end
  
  def teams_arr
    @teams
  end
  
  def teams
      Team.teams(@teams).sort_by{|t| teams_arr.flatten.index(t.abbr)} #keep them in the params' order
  end
  
  def main_chart
      'bar'
  end

  def series_data
    output = ''

              @contracts.each_with_index do |c, ix|
                output = output+"{\n  name: '"+ c.player.name + "',\n data: "+
                if c.team == teams.first
                  '['+c.salary.floor.to_s+", null]\n}"
                else
                  '[null,'+c.salary.floor.to_s+"]\n}"
                end
                
                if c != @contracts.last
                  output = output+",\n"
               end 

    end
    
    output
  end
end