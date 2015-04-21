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
  
  def series_data
    output = "name: 'Teams',\n colorByPoint: true,\n data: [\n"
            
            teams.each_with_index do |t, i|
                output = output + 
                "{ name: '" + t.abbr + "',\n" + 
                "  y: "+ t.contracts.year(@year).sum(:salary).floor.to_s + ",\n" +
                "  drilldown: '" + t.abbr + "'}"
              
              if t != teams.last
                output = output + ",\n"
              else
                output = output + "]"
              end
            end
            
    output
  end
  
  def drilldown_data
    output = ''
    
    teams.each_with_index do |t, i|
           output = output + "\n{ id: '" + t.abbr + "',\n" +
                "type: '" + drill_chart + "',\n" +
                "data:[ "
                
             t.contracts.year(@year).each_with_index do |c, ix|
             output = output + "['" + c.player.name.gsub("'", %q(\\\')) + "' , " + c.salary.floor.to_s + "]"
             
               if ix != t.contracts.year(@year).size - 1
                    output = output + ",\n"
               end
               
             end
                    
           output = output + "\n]}"
           
           if i != teams.size - 1
             output = output + ","
           end
     end
     output
  end
end