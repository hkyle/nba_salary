module MainHelper
  def series_data
    if @chart.class == StatChart
      stat_series
    elsif @chart.class == LeagueChart
      league_series
    elsif @chart.class == CompareChart
      compare_series
    end
  end
  
  def groom_name(name)
    name.gsub("'", %q(\\\'))
  end
  
  def drilldown_data
    if @chart.class == LeagueChart
      league_drilldown
    end
  end
  
  def league_drilldown
    output = ''
    
    @chart.teams.each_with_index do |t, i|
           output = output + "\n{ id: '" + t.abbr + "',\n" +
                "type: '" + @chart.drill_chart + "',\n" +
                "data:[ "
                
             t.contracts.year(@chart.year).each_with_index do |c, ix|
             output = output + "['" + groom_name(c.player.name) + "' , " + c.salary.floor.to_s + "]"
             
               if ix != t.contracts.year(@chart.year).size - 1
                    output = output + ",\n"
               end
               
             end
                    
           output = output + "\n]}"
           
           if i != @chart.teams.size - 1
             output = output + ","
           end
     end
     output
  end
  
  def compare_series
    output = ''

        @chart.contracts.each_with_index do |c, ix|
          output = output + "{ name: '" + groom_name(c.player.name) + "',\n  data: "+
          if c.team == @chart.teams.first
             '['+c.salary.floor.to_s+", null] }"
          else
             '[null,'+c.salary.floor.to_s+"] }"
          end
                
          if c != @chart.contracts.last
            output = output+",\n"
          end 
        end
    
    output
  end
  
  def league_series
    output = "name: 'Teams',\n colorByPoint: true,\n data: [\n"
            
            @chart.teams.each_with_index do |t, i|
                output = output + 
                "{ name: '" + t.abbr + "',\n" + 
                "  y: "+ t.contracts.year(@chart.year).sum(:salary).floor.to_s + ",\n" +
                "  drilldown: '" + t.abbr + "'}"
              
              if t != @chart.teams.last
                output = output + ",\n"
              else
                output = output + "]"
              end
            end
            
    output
  end
  
  def stat_series
    output = ""
            
            @chart.teams.each_with_index do |t, i|
              output = output + 
                  "{ name: ' #{t.abbr}',\n color: 'rgba(#{rand(0..256).to_s}, #{rand(0..256).to_s}, #{rand(0..256).to_s}, 1)',\n data: ["
              
              t.contracts.year(@chart.year).each_with_index do |c, ix|
              if !c.player.advanced_stats.where('mp > ?', 200).first.nil?
                  output = output + 
                  " { name: '#{groom_name(c.player.name)} (#{c.team.abbr})',\n" + 
                  "x: #{c.salary.floor.to_s},\n" + 
                  "y: #{c.player.advanced_stats.first[@chart.stat].to_s}},\n"
              end
              
            end
            
            #remove the linebreak and comma since it's the last data block
            output = output.chop!.chop! + "]}"
            
            if t != @chart.teams.last
                    output = output + ",\n"
            end
                  
          end
            
    output
  end
end
