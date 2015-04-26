class StatChart < Chart
  attr_reader :stat
  
  def initialize(params)
    super
    @stat = params[:stat].downcase
  end
  
  def stat
    @stat
  end
  
  def teams
      Team.all.order(:abbr)
  end
  
  def main_chart
      'scatter'
  end
  
  def series_data
    output = ""
            
            teams.each_with_index do |t, i|
              output = output + 
                  "{ name: ' #{t.abbr}',\n color: 'rgba(#{rand(0..256).to_s}, #{rand(0..256).to_s}, #{rand(0..256).to_s}, 1)',\n data: ["
              
              t.contracts.year(@year).each_with_index do |c, ix|
              if !c.player.advanced_stats.where('mp > ?', 200).first.nil?
                  output = output + 
                  " { name: '#{c.player.name.gsub("'", %q(\\\'))} (#{c.team.abbr})',\n" + 
                  "x: #{c.salary.floor.to_s},\n" + 
                  "y: #{c.player.advanced_stats.first[@stat].to_s}},\n"
              end
              
            end
            
            #remove the linebreak and comma since it's the last data block
            output = output.chop!.chop! + "]}"
            
            if t != teams.last
                    output = output + ",\n"
            end
                  
          end
            
    output
  end
end