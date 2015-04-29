class StatChart < Chart
  attr_reader :stat
  
  def initialize(params)
    super
    @stat = params[:stat].downcase
  end
  
  def self.stat_list
    list = [ {val: 'per', text: 'PER'}, {val: 'ts_pct', text: 'True Shooting %'}, {val: 'trb_pct', text: 'Rebounding %'}, {val: 'ast_pct', text: 'Assist %'}, 
             {val: 'stl_pct', text: 'Steal %'}, {val: 'blk_pct', text: 'Block %'}, {val: 'tov_pct', text: 'Turnover %'}, {val: 'usg_pct', text: 'Usage %'}, 
             {val: 'ows', text: 'Offensive Win Shares'}, {val: 'dws', text: 'Defensive Win Shares'}, {val: 'ws', text: 'Win Shares'}, {val: 'ws_48', text: 'Win Shares/48 Mins'} 
           ]
           
    list.sort_by{ |l| l[:text]}
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